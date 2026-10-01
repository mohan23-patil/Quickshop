package com.ServletContainer;

import com.dao.ProductDao;
import com.sun.net.httpserver.HttpServer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deleteProduct")
public class ProductDeleteServlet extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productId = req.getParameter("productId");
        int k = new ProductDao().deleteProduct(productId);
        if (k > 0)
        {
//            req.setAttribute("msg","Product Deleted SuccessFully");
//
            resp.sendRedirect(req.getContextPath() + "/viewAllProduct");
        }
        else
        {
            req.setAttribute("msg","Somethings is Wrong! Your Passing Id No : "+productId+" Is Wrong");
//
        }
    }


}
