using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class MovieManager
    {
        public static List<Movies> GetMovies()
        {
            return MovieService.GetMovies();
        }
    }
}
