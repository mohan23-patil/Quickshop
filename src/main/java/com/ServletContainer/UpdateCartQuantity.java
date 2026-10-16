package com.ServletContainer;

import com.dao.CartDao;
import com.entity.Cart_Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/updateCart")
public class UpdateCartQuantity extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        HttpSession session = req.getSession(false);

        // Check whether the user is logged in
        if (session == null || session.getAttribute("username") == null)
        {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        String productId = req.getParameter("productId");
        String action = req.getParameter("action");

        // Validate request parameters
        if (productId == null || productId.trim().isEmpty()
                || action == null)
        {
            session.setAttribute("cartMessage", "Invalid cart request.");
            resp.sendRedirect(req.getContextPath() + "/viewCart");
            return;
        }

        try
        {
            CartDao dao = new CartDao();

            // Get the logged-in user's cart items
            List<Cart_Item> cartItems = dao.viewCart(username);

            Cart_Item selectedItem = null;

            for (Cart_Item item : cartItems)
            {
                if (productId.equals(item.getProductId()))
                {
                    selectedItem = item;
                    break;
                }
            }

            // Make sure the product exists in this user's cart
            if (selectedItem == null)
            {
                session.setAttribute("cartMessage",
                        "Product not found in your cart.");

                resp.sendRedirect(req.getContextPath() + "/viewCart");
                return;
            }

            int currentQuantity = selectedItem.getQuantity();
            int availableQty = selectedItem.getAvailableQty();

            // Increase quantity
            if ("increase".equals(action))
            {
                if (currentQuantity < availableQty)
                {
                    dao.updateCartItem(
                            username,
                            productId,
                            currentQuantity + 1
                    );

                    session.removeAttribute("cartMessage");
                }
                else
                {
                    session.setAttribute(
                            "cartMessage",
                            "Sorry, only " + availableQty
                                    + " items are available in stock."
                    );
                }
            }

            // Decrease quantity
            else if ("decrease".equals(action))
            {
                if (currentQuantity > 1)
                {
                    dao.updateCartItem(
                            username,
                            productId,
                            currentQuantity - 1
                    );

                    session.removeAttribute("cartMessage");
                }
                else
                {
                    // If quantity is 1, remove the item from the cart
                    dao.deleteCartItem(username, productId);
                    session.removeAttribute("cartMessage");
                }
            }
            else
            {
                session.setAttribute("cartMessage",
                        "Invalid quantity action.");
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();

            session.setAttribute(
                    "cartMessage",
                    "Unable to update your cart. Please try again."
            );
        }

        // Return to the cart page
        resp.sendRedirect(req.getContextPath() + "/viewCart");
    }
}
