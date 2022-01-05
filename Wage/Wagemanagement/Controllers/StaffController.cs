using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wagemanagement.Models;

namespace Wagemanagement.Controllers
{
    public class StaffController : Controller
    {
        // GET: Staff
        public ActionResult StaffIndex()
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                var cwa = db.Staff.ToList();
                return View(cwa);
            }

        }
        //查询表数据
        public string StaffSet(int page, int limit)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                var data = db.Staff_View.ToList();

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
        // //奖金删除表
        [HttpPost]
        public bool StaffSel(int id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Staff.Find(id);
                db.Staff.Remove(data);
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
        public ActionResult EditStaff(int? id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var b = db.Staff.Find(id);
                var Role_id = b.Role_id;
                var Grade_Id = b.Grade_Id;
                var Store_Id = b.Store_Id;
                var Department_Id = b.Department_Id;
                ViewBag.Grade1 = db.Grade.ToList();
                
                ViewBag.Store1 = db.Store.ToList();
                ViewBag.Department1 = db.Department.ToList();
                ViewBag.Role = db.Role.FirstOrDefault(c => c.Role_id == Role_id).Role_Name;
                ViewBag.Grade = db.Grade.FirstOrDefault(c => c.Grade_Id == Grade_Id).GradeName;
                ViewBag.Store = db.Store.FirstOrDefault(c => c.Store_Id == Store_Id).Store_Name;
                ViewBag.Department = db.Department.FirstOrDefault(c => c.Department_Id == Department_Id).Dt_Name;
                ViewBag.info1 = db.Staff.ToList();
                return View(b);
            }
        }
        //更新修改表数据
        public bool UpdateStaff(Staff_View staff_View)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var Staff_Pwd = db.Staff.FirstOrDefault(p => p.Staff_id == staff_View.Staff_id).Staff_Pwd;

                var Grade = db.Grade.FirstOrDefault(p => p.GradeName == staff_View.GradeName);
                var Role = db.Role.FirstOrDefault(p => p.Role_Name == staff_View.Role_Name);
                var Store = db.Store.FirstOrDefault(p => p.Store_Name == staff_View.Store_Name);
                var Department = db.Department.FirstOrDefault(p => p.Dt_Name == staff_View.Dt_Name);

                var staff = db.Staff.Find(staff_View.Staff_id);
                staff.Staff_Name = staff_View.Staff_Name;
                staff.Staff_Pwd = Staff_Pwd;
                staff.Sraff_State = staff_View.Sraff_State;
                staff.Role_id = Role.Role_id;
                staff.Grade_Id = Grade.Grade_Id;
                staff.Department_Id = Department.Department_Id;
                staff.Staff_Sex = staff_View.Staff_Sex;
                staff.Staff_Address = staff_View.Staff_Address;
                staff.Staff_Phone = staff_View.Staff_Phone;
                staff.Store_Id = Store.Store_Id;
                staff.Staff_Email = staff_View.Staff_Email;
                staff.Staff_hiredate = staff_View.Staff_hiredate;
                staff.Staff_Remark = staff_View.Staff_Remark;
                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                return false;
            }
        }
        [HttpPost]
        //模糊查询奖金名数据
        public string StaffSelect(int page, int limit,string Staff_id, string Staff_Name, string Store_Name, string GradeName, string Role_Name, string Dt_Name, string Staff_Address, string Staff_Phone,string Sraff_State,string Staff_Sex, string Staff_hiredate)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                string sex ="";
                if (Staff_Sex == "男")
                {
                    sex = "0";
                }
                else if (Staff_Sex == "女")
                {
                     sex = "1";
                }
             

                var data = db.Staff_View.Where(p => p.Staff_id.ToString().Contains(Staff_id)&& p.Staff_Name.Contains(Staff_Name) && p.Store_Name.Contains(Store_Name) && p.GradeName.Contains(GradeName) && p.Role_Name.Contains(Role_Name) && p.Dt_Name.Contains(Dt_Name) && p.Staff_Address.Contains(Staff_Address) && p.Staff_Phone.ToString().Contains(Staff_Phone) && p.Sraff_State.ToString().Contains(Sraff_State) && p.Staff_Sex.ToString().Contains(sex) && p.Staff_hiredate.ToString().Contains(Staff_hiredate)).ToList();
                var data2 = data.Skip((page - 1) * limit).Take(limit).ToList();
                var d = new { code = 0, msg = "", count = data.Count, data = data2 };
                return JsonConvert.SerializeObject(d);
            }
        }
        //删除
        [HttpPost]
        public JsonResult Remove(string[] id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                foreach (var item in id)
                {
                    int Staff_id = int.Parse(item);
                    var da = db.Staff.FirstOrDefault(c => c.Staff_id == Staff_id);

                    db.Staff.Remove(da);
                }
                if (db.SaveChanges() > 0)
                {
                    return Json(new { state = 10000 });
                }
                ;
                return Json(new { state = 100020 });
            }
        }
        //添加表试图
        public ActionResult AddStaff()
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                ViewBag.Grade = db.Grade.ToList();
                ViewBag.Role = db.Role.ToList();
                ViewBag.Store = db.Store.ToList();
                ViewBag.Department = db.Department.ToList();
               
                return View();
            }
        }
        [HttpPost]
        //添加表数据
        public bool UpdateStaffData(Staff_View staff_View,string Staff_Pwd)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                

                var Grade = db.Grade.FirstOrDefault(p => p.GradeName == staff_View.GradeName);
                var Role = db.Role.FirstOrDefault(p => p.Role_Name == staff_View.Role_Name);
                var Store = db.Store.FirstOrDefault(p => p.Store_Name == staff_View.Store_Name);
                var Department = db.Department.FirstOrDefault(p => p.Dt_Name == staff_View.Dt_Name);

                Staff staff = new Staff
                {
                    Staff_id= staff_View.Staff_id,
                    Staff_Name = staff_View.Staff_Name,
                    Staff_Pwd = Staff_Pwd,
                    Sraff_State = staff_View.Sraff_State,
                    Role_id = Role.Role_id,
                    Grade_Id = Grade.Grade_Id,
                    Department_Id = Department.Department_Id,
                    Staff_Sex = staff_View.Staff_Sex,
                    Staff_Address = staff_View.Staff_Address,
                    Staff_Phone = staff_View.Staff_Phone,
                    Store_Id = Store.Store_Id,
                    Staff_Email = staff_View.Staff_Email,
                    Staff_hiredate = staff_View.Staff_hiredate,
                    Staff_Remark = staff_View.Staff_Remark
                };
                db.Staff.Add(staff);
                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                return false;
            }


        }
    }
}