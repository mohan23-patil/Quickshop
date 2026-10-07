package com.ServletContainer;

import com.dao.ProductDao;
import com.entity.Product;
import com.imagekit.ImageKitConfig;

import io.imagekit.client.ImageKitClient;
import io.imagekit.models.files.FileUploadParams;
import io.imagekit.models.files.FileUploadResponse;

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
        try
        {
            String productId = req.getParameter("productId");
            String productName = req.getParameter("productName");
            String category = req.getParameter("category");

            double price =
                    Double.parseDouble(req.getParameter("productPrice"));

            int qty =
                    Integer.parseInt(req.getParameter("productQty"));

            Part imagePart = req.getPart("productImage");

            /*
             * Get old product
             */
            Product oldProduct =
                    new ProductDao().getProductDetailsById(productId);

            if (oldProduct == null)
            {
                req.setAttribute(
                        "msg",
                        "Product not found with ID : " + productId
                );

                req.getRequestDispatcher("adminDashboard.jsp")
                        .forward(req, resp);

                return;
            }

            /*
             * Keep old image by default
             */
            String image = oldProduct.getImage();

            /*
             * If user selected a new image
             */
            if (imagePart != null &&
                    imagePart.getSize() > 0)
            {
                String fileName =
                        imagePart.getSubmittedFileName();

                /*
                 * Remove path information
                 */
                fileName =
                        fileName.replace("\\", "/");

                if (fileName.contains("/"))
                {
                    fileName =
                            fileName.substring(
                                    fileName.lastIndexOf("/") + 1
                            );
                }

                /*
                 * ImageKit Client
                 */
                ImageKitClient client =
                        ImageKitConfig.getClient();

                /*
                 * Upload new image to ImageKit
                 */
                FileUploadParams params =
                        FileUploadParams.builder()
                                .file(imagePart.getInputStream())
                                .fileName(fileName)
                                .folder("/quickshop/products")
                                .build();

                FileUploadResponse response =
                        client.files().upload(params);

                /*
                 * Get ImageKit URL
                 */
                image =
                        response.url().orElseThrow(
                                () -> new RuntimeException(
                                        "ImageKit did not return image URL"
                                )
                        );

                System.out.println(
                        "Updated ImageKit URL: " + image
                );
            }

            /*
             * Update product in database
             */
            int k =
                    new ProductDao().updateProduct(
                            productName,
                            category,
                            price,
                            qty,
                            image,
                            productId
                    );

            if (k > 0)
            {
                resp.sendRedirect(
                        req.getContextPath()
                                + "/viewAllProduct"
                );
            }
            else
            {
                req.setAttribute(
                        "msg",
                        "Something is Wrong! Product not Updated."
                );

                req.setAttribute(
                        "product",
                        oldProduct
                );

                req.getRequestDispatcher(
                                "updateProduct.jsp"
                        )
                        .forward(req, resp);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();

            req.setAttribute(
                    "msg",
                    "Something went wrong while updating the product!"
            );

            req.getRequestDispatcher(
                            "updateProduct.jsp"
                    )
                    .forward(req, resp);
        }
    }

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException
    {
        String prodId =
                req.getParameter("productId");

        Product product =
                new ProductDao().getProductDetailsById(prodId);

        if (product != null)
        {
            req.setAttribute(
                    "product",
                    product
            );

            req.getRequestDispatcher(
                            "updateProduct.jsp"
                    )
                    .forward(req, resp);
        }
        else
        {
            req.setAttribute(
                    "msg",
                    "Product is Not Found with Id : " + prodId
            );

            req.getRequestDispatcher(
                            "adminDashboard.jsp"
                    )
                    .forward(req, resp);
        }
    }
}