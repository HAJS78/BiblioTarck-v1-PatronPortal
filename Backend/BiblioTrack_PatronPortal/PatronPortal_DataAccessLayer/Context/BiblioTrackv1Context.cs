using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using PatronPortal_DataAccessLayer.Entities;

namespace PatronPortal_DataAccessLayer.Context;

public partial class BiblioTrackv1Context : DbContext
{
    public BiblioTrackv1Context()
    {
    }

    public BiblioTrackv1Context(DbContextOptions<BiblioTrackv1Context> options)
        : base(options)
    {
    }

    public virtual DbSet<Book> Books { get; set; }

    public virtual DbSet<BookCopiesBorrowingsReturning> BookCopiesBorrowingsReturnings { get; set; }

    public virtual DbSet<BookCopy> BookCopies { get; set; }

    public virtual DbSet<BooksTag> BooksTags { get; set; }

    public virtual DbSet<Fine> Fines { get; set; }

    public virtual DbSet<LibraryCard> LibraryCards { get; set; }

    public virtual DbSet<LibraryMember> LibraryMembers { get; set; }

    public virtual DbSet<LibraryMemberNotification> LibraryMemberNotifications { get; set; }

    public virtual DbSet<PatronFavorite> PatronFavorites { get; set; }

    public virtual DbSet<Payment> Payments { get; set; }

    public virtual DbSet<Person> People { get; set; }

    public virtual DbSet<Reservation> Reservations { get; set; }

    public virtual DbSet<StripePayment> StripePayments { get; set; }

    public virtual DbSet<Tag> Tags { get; set; }

   
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Book>(entity =>
        {
            entity.HasKey(e => e.BookRecordId);

            entity.HasIndex(e => e.CallNumber, "UX_Books_CallNumber").IsUnique();

            entity.HasIndex(e => e.Isbn, "UX_Books_ISBN").IsUnique();

            entity.Property(e => e.BookRecordId).HasColumnName("BookRecordID");
            entity.Property(e => e.Authors).HasMaxLength(500);
            entity.Property(e => e.CallNumber).HasMaxLength(200);
            entity.Property(e => e.Edition).HasMaxLength(50);
            entity.Property(e => e.Isbn)
                .HasMaxLength(20)
                .HasColumnName("ISBN");
            entity.Property(e => e.Language)
                .HasMaxLength(50)
                .IsFixedLength();
            entity.Property(e => e.Location).HasMaxLength(200);
            entity.Property(e => e.NumberOfPages).HasMaxLength(20);
            entity.Property(e => e.Publisher).HasMaxLength(255);
            entity.Property(e => e.Title).HasMaxLength(500);
        });

        modelBuilder.Entity<BookCopiesBorrowingsReturning>(entity =>
        {
            entity.HasKey(e => e.BookCopyBorrowingReturningId).HasName("PK_BorrowingsReturnings");

            entity.Property(e => e.BookCopyBorrowingReturningId).HasColumnName("BookCopyBorrowingReturningID");
            entity.Property(e => e.BookCopyRecordId).HasColumnName("BookCopyRecordID");
            entity.Property(e => e.LibraryCardRecordId).HasColumnName("LibraryCardRecordID");

            entity.HasOne(d => d.BookCopyRecord).WithMany(p => p.BookCopiesBorrowingsReturnings)
                .HasForeignKey(d => d.BookCopyRecordId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_BookCopiesBorrowingsReturnings_BookCopies");

            entity.HasOne(d => d.LibraryCardRecord).WithMany(p => p.BookCopiesBorrowingsReturnings)
                .HasForeignKey(d => d.LibraryCardRecordId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_BookCopiesBorrowingsReturnings_LibraryCards");
        });

        modelBuilder.Entity<BookCopy>(entity =>
        {
            entity.HasKey(e => e.BookCopyRecordId);

            entity.HasIndex(e => e.BookCopyBarcodeNumber, "UX_BookCopyBarcodeNumber").IsUnique();

            entity.Property(e => e.BookCopyRecordId).HasColumnName("BookCopyRecordID");
            entity.Property(e => e.BookCopyBarcodeNumber).HasMaxLength(20);
            entity.Property(e => e.BookRecordId).HasColumnName("BookRecordID");

            entity.HasOne(d => d.BookRecord).WithMany(p => p.BookCopies)
                .HasForeignKey(d => d.BookRecordId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_BookCopies_Books");
        });

        modelBuilder.Entity<BooksTag>(entity =>
        {
            entity.HasKey(e => e.BookTagRecordId);

            entity.ToTable("Books_Tags");

            entity.Property(e => e.BookTagRecordId).HasColumnName("BookTagRecordID");
            entity.Property(e => e.BookRecordId).HasColumnName("BookRecordID");
            entity.Property(e => e.TagRecordId).HasColumnName("TagRecordID");

            entity.HasOne(d => d.BookRecord).WithMany(p => p.BooksTags)
                .HasForeignKey(d => d.BookRecordId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Books_Tags_Books");

            entity.HasOne(d => d.TagRecord).WithMany(p => p.BooksTags)
                .HasForeignKey(d => d.TagRecordId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Books_Tags_Tags");
        });

        modelBuilder.Entity<Fine>(entity =>
        {
            entity.Property(e => e.FineId).HasColumnName("FineID");
            entity.Property(e => e.AddedByLibrarianRecordId).HasColumnName("AddedByLibrarianRecordID");
            entity.Property(e => e.AmountDue).HasColumnType("smallmoney");
            entity.Property(e => e.LibraryCardRecordId).HasColumnName("LibraryCardRecordID");
            entity.Property(e => e.PaymentId).HasColumnName("PaymentID");

            entity.HasOne(d => d.LibraryCardRecord).WithMany(p => p.Fines)
                .HasForeignKey(d => d.LibraryCardRecordId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Fines_LibraryCards");

            entity.HasOne(d => d.Payment).WithMany(p => p.Fines)
                .HasForeignKey(d => d.PaymentId)
                .HasConstraintName("FK_Fines_Payments");
        });

        modelBuilder.Entity<LibraryCard>(entity =>
        {
            entity.HasKey(e => e.LibraryCardRecordId);

            entity.HasIndex(e => e.LibraryCardNumber, "UX_LibraryCards_LibraryCardNumber").IsUnique();

            entity.Property(e => e.LibraryCardRecordId).HasColumnName("LibraryCardRecordID");
            entity.Property(e => e.LibraryCardNumber).HasMaxLength(64);
            entity.Property(e => e.MemberRecordId).HasColumnName("MemberRecordID");

            entity.HasOne(d => d.MemberRecord).WithMany(p => p.LibraryCards)
                .HasForeignKey(d => d.MemberRecordId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_LibraryCards_LibraryMembers");
        });

        modelBuilder.Entity<LibraryMember>(entity =>
        {
            entity.HasKey(e => e.MemberRecordId).HasName("PK_LibraryUsers");

            entity.HasIndex(e => e.UserName, "UX_LibraryMembers_UserName").IsUnique();

            entity.Property(e => e.MemberRecordId).HasColumnName("MemberRecordID");
            entity.Property(e => e.Password).HasMaxLength(50);
            entity.Property(e => e.PersonRecordId).HasColumnName("PersonRecordID");
            entity.Property(e => e.UserName).HasMaxLength(50);

            entity.HasOne(d => d.PersonRecord).WithMany(p => p.LibraryMembers)
                .HasForeignKey(d => d.PersonRecordId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_LibraryMembers_People");
        });

        modelBuilder.Entity<LibraryMemberNotification>(entity =>
        {
            entity.HasKey(e => e.NotificationId).HasName("PK__PatronNo__20CF2E3285C98899");

            entity.Property(e => e.NotificationId).HasColumnName("NotificationID");
            entity.Property(e => e.CreatedAt).HasDefaultValueSql("(CONVERT([date],getdate()))");
            entity.Property(e => e.CreatedByLibrarianRecordId).HasColumnName("CreatedByLibrarianRecordID");
            entity.Property(e => e.LibraryMemberRecordId).HasColumnName("LibraryMemberRecordID");
            entity.Property(e => e.Message).HasMaxLength(500);
            entity.Property(e => e.NotificationType).HasMaxLength(50);

            entity.HasOne(d => d.LibraryMemberRecord).WithMany(p => p.LibraryMemberNotifications)
                .HasForeignKey(d => d.LibraryMemberRecordId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Notifications_LibraryMembers");
        });

        modelBuilder.Entity<PatronFavorite>(entity =>
        {
            entity.HasKey(e => e.RecordId);

            entity.Property(e => e.RecordId).HasColumnName("RecordID");
            entity.Property(e => e.BookRecordId).HasColumnName("BookRecordID");
            entity.Property(e => e.MemberRecordId).HasColumnName("MemberRecordID");

            entity.HasOne(d => d.BookRecord).WithMany(p => p.PatronFavorites)
                .HasForeignKey(d => d.BookRecordId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_PatronFavorites_Books");

            entity.HasOne(d => d.MemberRecord).WithMany(p => p.PatronFavorites)
                .HasForeignKey(d => d.MemberRecordId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_PatronFavorites_LibraryMembers");
        });

        modelBuilder.Entity<Payment>(entity =>
        {
            entity.Property(e => e.PaymentId).HasColumnName("PaymentID");
            entity.Property(e => e.LibraryCardRecordId).HasColumnName("LibraryCardRecordID");
            entity.Property(e => e.ProcessedByLibrarianRecordId).HasColumnName("ProcessedByLibrarianRecordID");

            entity.HasOne(d => d.LibraryCardRecord).WithMany(p => p.Payments)
                .HasForeignKey(d => d.LibraryCardRecordId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Payments_LibraryCards");
        });

        modelBuilder.Entity<Person>(entity =>
        {
            entity.HasKey(e => e.PersonRecordId);

            entity.HasIndex(e => e.Email, "UX_People_Email").IsUnique();

            entity.Property(e => e.PersonRecordId).HasColumnName("PersonRecordID");
            entity.Property(e => e.Address).HasMaxLength(200);
            entity.Property(e => e.ApartmentNumber).HasMaxLength(10);
            entity.Property(e => e.City).HasMaxLength(50);
            entity.Property(e => e.Email).HasMaxLength(50);
            entity.Property(e => e.FirstName).HasMaxLength(50);
            entity.Property(e => e.LastName).HasMaxLength(50);
            entity.Property(e => e.PersonalPhoto).HasMaxLength(300);
            entity.Property(e => e.Phone).HasMaxLength(20);
            entity.Property(e => e.State).HasMaxLength(50);
            entity.Property(e => e.ZipCode).HasMaxLength(10);
        });

        modelBuilder.Entity<Reservation>(entity =>
        {
            entity.Property(e => e.ReservationId).HasColumnName("ReservationID");
            entity.Property(e => e.BookCopyRecordId).HasColumnName("BookCopyRecordID");
            entity.Property(e => e.LibraryCardRecordId).HasColumnName("LibraryCardRecordID");

            entity.HasOne(d => d.BookCopyRecord).WithMany(p => p.Reservations)
                .HasForeignKey(d => d.BookCopyRecordId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Reservations_BookCopies");

            entity.HasOne(d => d.LibraryCardRecord).WithMany(p => p.Reservations)
                .HasForeignKey(d => d.LibraryCardRecordId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Reservations_LibraryCards");
        });

        modelBuilder.Entity<StripePayment>(entity =>
        {
            entity.HasKey(e => e.StripePaymentRecordId);

            entity.Property(e => e.StripePaymentRecordId).HasColumnName("StripePaymentRecordID");
            entity.Property(e => e.DateCreated).HasColumnType("datetime");
            entity.Property(e => e.LibraryPaymentRecordId).HasColumnName("LibraryPaymentRecordID");
            entity.Property(e => e.PaymentIntentId)
                .HasMaxLength(50)
                .HasColumnName("PaymentIntentID");

            entity.HasOne(d => d.LibraryPaymentRecord).WithMany(p => p.StripePayments)
                .HasForeignKey(d => d.LibraryPaymentRecordId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_StripePayments_Payments");
        });

        modelBuilder.Entity<Tag>(entity =>
        {
            entity.HasKey(e => e.TagRecordId);

            entity.Property(e => e.TagRecordId).HasColumnName("TagRecordID");
            entity.Property(e => e.Tagword).HasMaxLength(100);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
