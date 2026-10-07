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

@WebServlet("/addProduct")
@MultipartConfig
public class ProductInsertServlet extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        try
        {
            String prodId = req.getParameter("productId");
            String prodName = req.getParameter("productName");
            String category = req.getParameter("category");

            double price =
                    Double.parseDouble(req.getParameter("productPrice"));

            int qty =
                    Integer.parseInt(req.getParameter("productQty"));

            Part imagePart = req.getPart("image");

            if (imagePart == null ||
                    imagePart.getSize() == 0)
            {
                req.setAttribute("msg",
                        "Please select a product image!");

                req.getRequestDispatcher("addProduct.html")
                        .forward(req, resp);

                return;
            }

            String fileName = imagePart.getSubmittedFileName();

            // Remove any path information from filename
            fileName = fileName.replace("\\", "/");

            if (fileName.contains("/"))
            {
                fileName =
                        fileName.substring(fileName.lastIndexOf("/") + 1);
            }

            /*
             * ImageKit Client
             */
            ImageKitClient client =
                    ImageKitConfig.getClient();

            /*
             * Upload image to ImageKit
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
             * ImageKit gives us the permanent image URL
             */
            String imageUrl = response.url().orElseThrow(
                    () -> new RuntimeException("ImageKit did not return image URL")
            );

            System.out.println("ImageKit URL: " + imageUrl);

            /*
             * Create Product object
             */
            Product pod = new Product();

            pod.setProductId(prodId);
            pod.setProductName(prodName);
            pod.setCategory(category);
            pod.setProductPrice(price);
            pod.setProductQty(qty);

            // Store ImageKit URL instead of filename
            pod.setImage(imageUrl);

            /*
             * Save product into database
             */
            int rowCount =
                    new ProductDao().insertProduct(pod);

            if (rowCount > 0)
            {
                resp.sendRedirect(
                        req.getContextPath()
                                + "/viewAllProduct");
            }
            else
            {
                req.setAttribute(
                        "msg",
                        "Something is Wrong! Product Not Stored Successfully!"
                );

                req.getRequestDispatcher("addProduct.html")
                        .forward(req, resp);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();

            req.setAttribute(
                    "msg",
                    "Something went wrong while uploading the product!"
            );

            req.getRequestDispatcher("addProduct.html")
                    .forward(req, resp);
        }
    }
}