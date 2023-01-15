using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Extensions
{
    public static class DateExtensions
    {
        public static int GetQuater(this DateTime dateTime) => (int)Math.Ceiling((double)dateTime.Month / 3.0);

        public static (DateTime SDate, DateTime EDate, int Year, int quarter) GetPreQuarter(this DateTime dateTime, int preCount = 1)
        {
            if (preCount < 1) throw new ArgumentOutOfRangeException(nameof(preCount));

            if (preCount != 1) GetPreQuarter(dateTime.AddMonths(-3), --preCount);

            int preQuarter = dateTime.AddMonths(-3).GetQuater();

            int year = dateTime.Year;

            if (preQuarter == 4)
            {
                year--;
            }

            DateTime sDate = DateTime.Parse($"{year}/{ (((preQuarter - 1) * 3) + 1).ToString("00") }/01");
            DateTime eDate = sDate.AddMonths(3).AddDays(-1);

            return (sDate, eDate, year, preQuarter);
        }
    }
}
