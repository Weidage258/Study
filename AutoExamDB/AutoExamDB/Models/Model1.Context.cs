﻿//------------------------------------------------------------------------------
// <auto-generated>
//     此代码已从模板生成。
//
//     手动更改此文件可能导致应用程序出现意外的行为。
//     如果重新生成代码，将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace AutoExamDB.Models
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class AutoExamDBEntities : DbContext
    {
        public AutoExamDBEntities()
            : base("name=AutoExamDBEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Account> Account { get; set; }
        public virtual DbSet<AccountRoles> AccountRoles { get; set; }
        public virtual DbSet<ClassInfo> ClassInfo { get; set; }
        public virtual DbSet<CourseInfo> CourseInfo { get; set; }
        public virtual DbSet<EduType> EduType { get; set; }
        public virtual DbSet<Exam> Exam { get; set; }
        public virtual DbSet<ExamInfo> ExamInfo { get; set; }
        public virtual DbSet<InClassRecord> InClassRecord { get; set; }
        public virtual DbSet<LoginRecord> LoginRecord { get; set; }
        public virtual DbSet<Menus> Menus { get; set; }
        public virtual DbSet<Paper> Paper { get; set; }
        public virtual DbSet<PaperInfo> PaperInfo { get; set; }
        public virtual DbSet<RoleMenus> RoleMenus { get; set; }
        public virtual DbSet<Roles> Roles { get; set; }
        public virtual DbSet<StuInfo> StuInfo { get; set; }
        public virtual DbSet<TeaInfo> TeaInfo { get; set; }
        public virtual DbSet<Topic> Topic { get; set; }
        public virtual DbSet<AccountMenus> AccountMenus { get; set; }
    }
}
