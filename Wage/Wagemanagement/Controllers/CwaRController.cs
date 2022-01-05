using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wagemanagement.Models;

namespace Wagemanagement.Controllers
{
    public class CwaRController : Controller
    {
        // GET: CwaR
        
        public string CwaRSet(int page, int limit)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                var data = db.Cwa_Rd_View.ToList();

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
        //BounsRSel
        //奖金删除表
        [HttpPost]
        public bool CwaRSel(int id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Cwa_Records.Find(id);
                db.Cwa_Records.Remove(data);
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
        public ActionResult EditCwaR(int? id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var b = db.Cwa_Records.Find(id);
                var Cwa_id = b.Cwa_id;
                ViewBag.info = db.Cwa.FirstOrDefault(c => c.Cwa_id== Cwa_id).Cwa_Name;
                ViewBag.info1 = db.Cwa.ToList();
                return View(b);
            }
        }
        //UpdateCwaR
        //更新修改表数据
        public bool UpdateCwaR(Cwa_Rd_View cwa_Rd_View)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var jiang = db.Cwa.FirstOrDefault(p => p.Cwa_Name == cwa_Rd_View.Cwa_Name);

                var b = db.Cwa_Records.Find(cwa_Rd_View.CR_id);
                b.Staff_id = cwa_Rd_View.Staff_id;
                b.Cwa_id = jiang.Cwa_id;
                b.CR_date = cwa_Rd_View.CR_date;
                b.CR_Frequency = cwa_Rd_View.CR_Frequency;
                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                return false;
            }
        }
        //CwaSelectS
        [HttpPost]
        //模糊查询奖金名数据
        public string CwaSelectS(int page, int limit, string Cwa_Name, string Staff_id, string CR_date,string CR_Frequency)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Cwa_Rd_View.Where(p => p.Cwa_Name.Contains(Cwa_Name) && p.Staff_id.ToString().Contains(Staff_id) && p.CR_date.ToString().Contains(CR_date)&&p.CR_Frequency.ToString().Contains(CR_Frequency)).ToList();
                var data2 = data.Skip((page - 1) * limit).Take(limit).ToList();
                var d = new { code = 0, msg = "", count = data.Count, data = data2 };
                return JsonConvert.SerializeObject(d);
            }
        }
        //AddCwaR
        //添加表试图
        public ActionResult AddCwaR()
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                ViewBag.info1 = db.Cwa.ToList();
                return View();
            }
        }
        //UpdateCwaRdate
        [HttpPost]
        //添加表数据
        public bool UpdateCwaRdate(Cwa_Rd_View cwa_Rd_View)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
              var chunzai= db.Cwa_Records.FirstOrDefault(p => p.Staff_id == cwa_Rd_View.Staff_id);
                if (chunzai!=null)
                {
                    var date = DateTime.Now.ToString("yyyy-MM");
                    var Cwaid = db.Cwa.FirstOrDefault(p => p.Cwa_Name == cwa_Rd_View.Cwa_Name).Cwa_id;

                    var cun = db.Cwa_Records.Where(p => p.CR_date.ToString().Contains(date)).FirstOrDefault(p => p.Staff_id == cwa_Rd_View.Staff_id&&p.Cwa_id== Cwaid);
                    if (cun != null)
                    {

                        cun.CR_Frequency += 1;


                        if (db.SaveChanges() > 0)
                        {
                            return true;
                        }
                        return false;
                    }
                    else {
                        var jiang = db.Cwa.FirstOrDefault(p => p.Cwa_Name == cwa_Rd_View.Cwa_Name);
                        Cwa_Records b = new Cwa_Records
                        {
                            Staff_id = cwa_Rd_View.Staff_id,
                            Cwa_id = jiang.Cwa_id,
                            CR_Frequency = 1,
                            CR_date = DateTime.Today
                        };
                        db.Cwa_Records.Add(b);

                        if (db.SaveChanges() > 0)
                        {
                            return true;
                        }
                        return false;
                    }
                  
                }
                else {
                    var jiang = db.Cwa.FirstOrDefault(p => p.Cwa_Name == cwa_Rd_View.Cwa_Name);

                    Cwa_Records b = new Cwa_Records
                    {
                        Staff_id = cwa_Rd_View.Staff_id,
                        Cwa_id = jiang.Cwa_id,
                        CR_Frequency = 1,
                         CR_date = DateTime.Today
                    };
                    db.Cwa_Records.Add(b);

                    if (db.SaveChanges() > 0)
                    {
                        return true;
                    }
                    return false;

                }
               
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