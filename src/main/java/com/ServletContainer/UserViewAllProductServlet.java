package com.ServletContainer;

import com.dao.ProductDao;
import com.entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/userViewAllProduct")
public class UserViewAllProductServlet extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> products = new ProductDao().viewAllPoduct();

        req.setAttribute("product", products);

        req.getRequestDispatcher("/userDashBoard.jsp").forward(req, resp);
    }
}
