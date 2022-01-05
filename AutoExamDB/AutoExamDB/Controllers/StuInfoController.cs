using AutoExamDB.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AutoExamDB.Controllers
{
    public class StuInfoController : Controller
    {
        // GET: StuInfo
        AutoExamDBEntities db = new AutoExamDBEntities();
        public ActionResult Index(int pagesize=7,int pageindex=1)
        {
            ViewBag.PageIndex = pageindex;//当前显示页面
            var stus = db.StuInfo;
            int count = stus.Count();//页码            
            ViewBag.Count = (int)Math.Ceiling(count * 1.0 / pagesize);//取整数
            var result = stus.OrderBy(s => s.StuNo).Skip((pageindex - 1) * pagesize).Take(pagesize).ToList();//只取当前页面的数据
            return View(result);
        }
        public ActionResult Add()
        {
            return View();
        }
        public ActionResult Edit()
        {
            return View();
        }
        public ActionResult Dele()
        {
            return View();
        }
    }
}