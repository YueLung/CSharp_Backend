using System;
using System.ComponentModel.DataAnnotations;


namespace Core.Models
{
    public enum PaginationOrderBy 
    {
        None = 0,
        Ascending = 1,
        Descending = 2,
    }

    public class PaginationQueryModel
    {
        /// <summary>
        /// 分頁號碼
        /// </summary>
        [Required]
        public int Page { get; set; }

        /// <summary>
        /// 分頁大小
        /// </summary>
        [Required]
        public int Size { get; set; }

        /// <summary>
        /// 排序欄位名稱
        /// </summary>
        [Required]
        public string Order { get; set; }

        /// <summary>
        /// 排序方式
        /// </summary>
        [Required]
        public PaginationOrderBy OrderBy { get; set; }
    }
}
