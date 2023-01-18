<%@ WebHandler Language="C#" CodeBehind="Upload.ashx.cs" Class="ProChicken.Upload" %>
using System;
using System.Web;
using System.IO;
using System.Collections.Generic;
public class UploadCS : IHttpHandler {
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Expires = -1;
        try
        {
            List<HttpPostedFile> files = (List<HttpPostedFile>)context.Cache[context.Request.QueryString["key"]];
            HttpPostedFile postedFile = context.Request.Files["Filedata"];
            files.Add(postedFile);
            string filename = postedFile.FileName;
            context.Response.Write(filename);
            context.Response.StatusCode = 200;
        }
        catch (Exception ex)
        {
            context.Response.Write("Error: " + ex.Message);
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}
