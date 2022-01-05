using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AutoExamDB.Filters
{
    public class AuthMenusAttribute: ActionFilterAttribute
    {         
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var routeData = filterContext.RequestContext.RouteData;
            if (routeData.Values.Count != 0)//如果用户访问的是控制器的动作
            {
                //拼接当前的访问菜单
                var url = "/" + routeData.Values["Controller"].ToString() + "/" + routeData.Values["Action"].ToString();
                var accountMenus = HttpContext.Current.Session["Menus"] as List<AutoExamDB.Models.AccountMenus>;
                if (HttpContext.Current.Session["Login"] != null && (HttpContext.Current.Session["Login"] as AutoExamDB.Models.Account).LoginName != "admin" &&
                    accountMenus.Where(am => am.MenuUrl == url).FirstOrDefault() == null)//已登陆且不是admin，且无权限访问此页面
                {
                    filterContext.Result = new RedirectResult("/Home/Index");//重新指向首页
                }
            }
        }
    }
}