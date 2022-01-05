using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wagemanagement.Models;

namespace Wagemanagement.Controllers
{
    public class GradeController : Controller
    {
        // GET: Grade
        public ActionResult GradeIndex()
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var Grade = db.Grade.ToList();
                return View(Grade);
            }
        }
        //DepSet 查询
        public string GradeSet(int page, int limit)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                var data = db.Grade.ToList();

                var data2 = data.Skip((page - 1) * limit).Take(limit).ToList();
                var d = new
                {
                    code = "0",
                    msg = ""
                    ,
                    count = data.Count
                    ,
                    data = data2
                };

                return JsonConvert.SerializeObject(d);
            }
        }
        //奖金删除表
        [HttpPost]
        public bool GradeSel(int id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Grade.Find(id);
                db.Grade.Remove(data);
                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }


            }

        }
        //EditGrade
        //修改表试图
        public ActionResult EditGrade(int? id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var b = db.Grade.Find(id);
                return View(b);
            }
        }
        //UpdateGrade
        //更新修改表数据
        public bool UpdateGrade(Grade grade)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var b = db.Grade.Find(grade.Grade_Id);
                b.GradeName = grade.GradeName;
                b.Grade_price = grade.Grade_price;


                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                return false;
            }
        }
        [HttpPost]
        //模糊查询奖金名数据
        public string GradeSelect(int page, int limit, string GradeName)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Grade.Where(p => p.GradeName.Contains(GradeName)).ToList();

                var data2 = data.Skip((page - 1) * limit).Take(limit).ToList();
                var d = new { code = 0, msg = "", count = data.Count, data = data2 };

                return JsonConvert.SerializeObject(d);
            }

        }
        //添加表试图
        public ActionResult AddGrade()
        {
            return View();
        }
        // UpdateGradedata
        [HttpPost]
        //添加表数据
        public bool UpdateGradedata(Grade grade)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                Grade b = new Grade
                {
                    GradeName = grade.GradeName,
                    Grade_price=grade.Grade_price

                };
                db.Grade.Add(b);

                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                return false;
            }


        }

    }
}