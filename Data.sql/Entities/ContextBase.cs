using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Core.Entities;
using Data.sql;

namespace Data.sql.Entities
{
    public partial class ContextBase : DbContext
    {
        public virtual DbSet<Base_Auth_User> Base_Auth_User { get; set; }

        public ContextBase(DbContextOptions<ContextBase> options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Base_Auth_User>(entity =>
            {
                entity.HasKey(e => e.Id)
                    .IsClustered(false);

                entity.HasIndex(e => e.Cix, "Cix_Base_Auth_User")
                    .IsClustered();

                entity.Property(e => e.Id).HasDefaultValueSql("(newsequentialid())");

                entity.Property(e => e.Account)
                    .IsRequired()
                    .HasMaxLength(200);

                entity.Property(e => e.Cix).ValueGeneratedOnAdd();

                entity.Property(e => e.DepCode)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.EmpId)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(200);

                entity.Property(e => e.PasswordHash)
                    .IsRequired()
                    .HasMaxLength(200);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
