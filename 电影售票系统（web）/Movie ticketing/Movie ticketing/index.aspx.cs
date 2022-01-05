using BLL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Movie_ticketing
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bind();
            bind1();
            bind2();
        }
        public void bind()
        {
            this.HotMovieList.DataSource = MovieManager.GetMovies();
            this.HotMovieList.DataBind();
        }
        public void bind1()
        {
            Movie_ticketingEntities db = new Movie_ticketingEntities();
            var movie = db.Movies.ToList();
            var date = DateTime.Now;
            var moviedate = movie.Where(p => p.MovieShowDate > date);
            this.DataList1.DataSource = moviedate.ToList();
               this.DataList1.DataBind();
        }
        public void bind2()
        {
            this.DataList2.DataSource = MovieManager.GetMovies();
            this.DataList2.DataBind();
        }
    }
}