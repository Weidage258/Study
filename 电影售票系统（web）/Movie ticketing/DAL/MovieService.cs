using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class MovieService
    {
        public static Movie_ticketingEntities db = new Movie_ticketingEntities();

        //查询热门的前八个电影，按票房排序
        public static List<Movies> GetMovies()
        {
            var movie= db.Movies.ToList();
            //var date = DateTime.Now;
            //var moviedate = movie.Where(p => p.MovieShowDate.Month + 1 > date.Month && p.MovieShowDate < date).OrderByDescending(a => a.Score);
            return movie.ToList();
        }
    }
}
