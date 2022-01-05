using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace AutoExamDB.Modules
{
    public class MenuCtrlsModule : IHttpModule
    {
        public void Dispose()
        {
            
        }

        public void Init(HttpApplication context)
        {
            //会话密钥生效后进行账户访问菜单权限检查
            context.AcquireRequestState += context_MenuCtrls;
        }
        //菜单权限检查
        void context_MenuCtrls(object sender, EventArgs e)
        {
            HttpApplication app = sender as HttpApplication;
            // 获取请求的控制器和动作
            var routeData = app.Request.RequestContext.RouteData;
            if (routeData.Values.Count!=0)//如果用户访问的是控制器的动作
            {
                //拼接当前的访问菜单
                var url = "/"+routeData.Values["Controller"].ToString()+ "/" + routeData.Values["Action"].ToString();
                var accountMenus = app.Session["Menus"] as List<AutoExamDB.Models.AccountMenus>;
                
                if (app.Session["Login"] == null && url!= "/Home/Login")//没登录，且不是请求登录页面
                {
                    app.Response.Redirect("~/Home/Login", true);//重新指向登录页面
                    //app.Server.Transfer(,);
                }
                else if (app.Session["Login"] != null && (app.Session["Login"] as AutoExamDB.Models.Account).LoginName!="admin" &&
                    accountMenus.Where(am => am.MenuUrl == url).FirstOrDefault() == null )//已登陆且不是admin，且无权限访问此页面
                {
                    app.Response.Redirect("~/Home/Index", false);//重新指向首页
                }
            }




            //// 正则表达式，判断请求是否符合格式
            //Regex regex_request = new Regex(@"\w+_\d+\.html");
            //if (regex_request.IsMatch(url))
            //{//需要进行URL重写
            //    int line = url.LastIndexOf("_"); // 截取URL中的编号
            //    int dot = url.LastIndexOf(".");
            //    string id = url.Substring(line + 1, dot - line - 1);
            //    // 拼接真实的URL
            //    string directUrl = "~/GoodsList.aspx?id=" + id;
            //    app.Server.Transfer(directUrl);
            //}
        }

    }
}