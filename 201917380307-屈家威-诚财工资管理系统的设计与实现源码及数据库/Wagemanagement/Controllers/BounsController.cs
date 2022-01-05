
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wagemanagement.Models;

namespace Wagemanagement.Controllers
{
    public class BounsController : Controller
    {
        // 获取表数据
       
        public string BounsSet(int page,int limit)
       {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                
                var data = db.Bonus.ToList();
                
                var data2 = data.Skip((page - 1) * limit).Take(limit).ToList();
                var d = new {
                    code = "0",
                    msg = ""
                    , count = data.Count
                    , data = data2
                };
               
                return JsonConvert.SerializeObject(d);
            }
           
        }
        //模糊查询奖金名数据
        public string BounsSelect(int page, int limit,string BonusName)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Bonus.Where(p => p.BonusName.Contains(BonusName)).ToList();

                var data2 = data.Skip((page - 1) * limit).Take(limit).ToList();
                var d = new { code = 0, msg = "", count = data.Count, data = data2 };

                return JsonConvert.SerializeObject(d);
            }

        }
        //奖金删除表
        [HttpPost]
        public bool BounsSel(int id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Bonus.Find(id);
                    db.Bonus.Remove(data);
                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                else {
                    return false;
                }
                    
                
            }

        }
        //修改表试图
        public ActionResult EditBonus(int? id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var b = db.Bonus.Find(id);
                return View(b);
            }
        }
        //更新修改表数据
        public bool UpdateBonus(Bonus bonus)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var b = db.Bonus.Find(bonus.Bonus_Id);
                b.BonusName = bonus.BonusName;
                b.Bonus_pirce = bonus.Bonus_pirce;
                
                if (db.SaveChanges()>0)
                {
                    return true;
                }
                return false;
            }
        }
        //添加表试图
        public ActionResult AddBonus()
        {
                return View();
        }
        [HttpPost]
        //添加表数据
        public bool UpdateBonusData(Bonus bonus)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                Bonus b = new Bonus
                {
                    BonusName = bonus.BonusName,
                    Bonus_pirce = bonus.Bonus_pirce
                };
                db.Bonus.Add(b);

                if (db.SaveChanges()>0)
                {
                    return true;
                }
                return false;
            }
               
              
            }
        //批量删除
        [HttpPost]
        public JsonResult Remove(string[] id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                foreach (var item in id)
                {
                    int daa = int.Parse(item);
                    var da = db.Bonus.FirstOrDefault(c => c.Bonus_Id == daa);
                    
                    db.Bonus.Remove(da);
                }
                db.SaveChanges();
                return Json(new { state = 10000 });
            }
        }
    }
    }
