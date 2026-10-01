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

@WebServlet("/addProduct")
@MultipartConfig
public class ProductInsertServlet extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        String prodId = req.getParameter("productId");
        String prodName = req.getParameter("productName");
        String category = req.getParameter("category");
        double price = Double.parseDouble(req.getParameter("productPrice"));
        int qty = Integer.parseInt(req.getParameter("productQty"));

        Part imagePart = req.getPart("image");

        String fileName = imagePart.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("/images");

        imagePart.write(uploadPath + "/" + fileName);

        Product pod = new Product();

        pod.setProductId(prodId);
        pod.setProductName(prodName);
        pod.setCategory(category);
        pod.setProductPrice(price);
        pod.setProductQty(qty);
        pod.setImage(fileName);

        int rowCount = new ProductDao().insertProduct(pod);

        if (rowCount > 0)
        {
//            req.setAttribute("msg", "Product Stored Successfully");
//            req.getRequestDispatcher("adminDashboard.jsp").forward(req, resp);
            resp.sendRedirect(req.getContextPath() + "/viewAllProduct");
        }
        else
        {
            req.setAttribute("msg",
                    "Something is Wrong! Product Not Stored Successfully!");

            req.getRequestDispatcher("addProduct.html").forward(req, resp);
        }
    }
}

