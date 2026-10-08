using System;
using System.Collections.Generic;

namespace PatronPortal_DataAccessLayer.Entities;

public partial class Person
{
    public int PersonRecordId { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public DateOnly DateOfBirth { get; set; }

    public string Address { get; set; } = null!;

    public string State { get; set; } = null!;

    public string City { get; set; } = null!;

    public string ApartmentNumber { get; set; } = null!;

    public string ZipCode { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public string Email { get; set; } = null!;

    public byte PersonRole { get; set; }

    public string? PersonalPhoto { get; set; }

    public virtual ICollection<LibraryMember> LibraryMembers { get; set; } = new List<LibraryMember>();
}
