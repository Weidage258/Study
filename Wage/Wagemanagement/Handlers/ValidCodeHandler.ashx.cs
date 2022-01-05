using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace Wagemanagement.Handlers
{
    /// <summary>
    /// ValidCodeHandler 的摘要说明
    /// </summary>
    public class ValidCodeHandler : IHttpHandler,IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            Color[] colors = new Color[]
           {
                Color.Red,Color.Green,Color.Yellow,Color.Blue,Color.AliceBlue,Color.Aqua,Color.Bisque,Color.Brown
           };
            Image img = new Bitmap(100, 36);
            Graphics graphics = Graphics.FromImage(img);
            Random random = new Random(DateTime.Now.Millisecond);
            int charNum1 = random.Next(1, 9);
            char charNum2 = '*';
            int charNum3 = random.Next(1, 9);
            char charNum4 = '=';
            //保存验证码
            context.Session["sn"] = charNum1 * charNum3;

            Font font = new Font("宋体", 24);
            Brush brush1 = new SolidBrush(colors[random.Next(0, colors.Length - 1)]);
            graphics.DrawString((charNum1).ToString(), font, brush1, 7, -3);
            Brush brush2 = new SolidBrush(colors[random.Next(0, colors.Length - 1)]);
            graphics.DrawString((charNum2).ToString(), font, brush2, 26, 0);
            Brush brush3 = new SolidBrush(colors[random.Next(0, colors.Length - 1)]);
            graphics.DrawString((charNum3).ToString(), font, brush3, 50, 3);
            Brush brush4 = new SolidBrush(colors[random.Next(0, colors.Length - 1)]);
            graphics.DrawString((charNum4).ToString(), font, brush4, 70, 0);
            context.Response.ContentType = "image/jpeg";
            img.Save(context.Response.OutputStream, ImageFormat.Jpeg);
            img.Dispose();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}