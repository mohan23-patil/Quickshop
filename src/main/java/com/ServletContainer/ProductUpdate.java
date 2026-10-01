package com.ServletContainer;

import com.dao.ProductDao;
import com.entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;

@WebServlet("/updateProduct")
@MultipartConfig
public class ProductUpdate extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        String productId = req.getParameter("productId");
        String productName = req.getParameter("productName");
        String category = req.getParameter("category");
        double price = Double.parseDouble(req.getParameter("productPrice"));
        int qty = Integer.parseInt(req.getParameter("productQty"));

        Part imagePart = req.getPart("productImage");

        String image = imagePart.getSubmittedFileName();

        Product oldProduct = new ProductDao().getProductDetailsById(productId);

        if (image == null || image.isEmpty())
        {
            image = oldProduct.getImage();
        }
        else
        {
            String uploadPath = getServletContext().getRealPath("/images");

            imagePart.write(uploadPath + "/" + image);
        }

        int k = new ProductDao().updateProduct(
                productName,
                category,
                price,
                qty,
                image,
                productId
        );

        if (k > 0)
        {
            resp.sendRedirect(req.getContextPath() + "/viewAllProduct");
        }
        else
        {
            req.setAttribute("msg",
                    "Something is Wrong! Product not Updated.");

            req.setAttribute("product",
                    oldProduct);

            req.getRequestDispatcher("updateProduct.jsp")
                    .forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        String prodId = req.getParameter("productId");

        Product product =
                new ProductDao().getProductDetailsById(prodId);

        if (product != null)
        {
            req.setAttribute("product", product);

            req.getRequestDispatcher("updateProduct.jsp")
                    .forward(req, resp);
        }
        else
        {
            req.setAttribute("msg",
                    "Product is Not Found with Id : " + prodId);

            req.getRequestDispatcher("adminDashboard.jsp")
                    .forward(req, resp);
        }
    }
}
