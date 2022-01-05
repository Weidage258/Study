using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wagemanagement.Models;

namespace Wagemanagement.Controllers
{
    public class DepartmentController : Controller
    {
        // GET: Department 部门试图
        public ActionResult DepIndex()
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var Dep = db.Department.ToList();
                return View(Dep);
            }
        }
        //DepSet 查询
        public string DepSet(int page, int limit)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                var data = db.Department.ToList();

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
        public bool DepSel(int id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Department.Find(id);
                db.Department.Remove(data);
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
        //修改表试图
        public ActionResult EditDep(int? id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var b = db.Department.Find(id);
                return View(b);
            }
        }
        //更新修改表数据
        public bool UpdateDep(Department department)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var b = db.Department.Find(department.Department_Id);
                b.Dt_Name = department.Dt_Name;
             

                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                return false;
            }
        }
        [HttpPost]
        //模糊查询奖金名数据
        public string DepSelect(int page, int limit, string Dt_Name)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Department.Where(p => p.Dt_Name.Contains(Dt_Name)).ToList();

                var data2 = data.Skip((page - 1) * limit).Take(limit).ToList();
                var d = new { code = 0, msg = "", count = data.Count, data = data2 };

                return JsonConvert.SerializeObject(d);
            }

        }
        //添加表试图
        public ActionResult AddDep()
        {
            return View();
        }
        //UpdateDepdate
        [HttpPost]
        //添加表数据
        public bool UpdateDepdate(Department department)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                Department b = new Department
                {
                    Dt_Name = department.Dt_Name,
                    
                };
                db.Department.Add(b);

                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                return false;
            }


        }
        //批量删除
        [HttpPost]
        public JsonResult RemoveS(string[] id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                foreach (var item in id)
                {
                    int CR_id = int.Parse(item);
                    var da = db.Cwa_Records.FirstOrDefault(c => c.CR_id == CR_id);

                    db.Cwa_Records.Remove(da);
                }
                if (db.SaveChanges() > 0)
                {
                    return Json(new { state = 10000 });
                }
                ;
                return Json(new { state = 100020 });
            }
        }
    }
}
