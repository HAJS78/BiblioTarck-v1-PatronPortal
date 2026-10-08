using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_DataAccessLayer.Repositories.Projections;
using PatronPortal_DataAccessLayer.Repository.Projections;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PatronPortal_BusinessLogicLayer.Mappers
{
    public static class UnpaidFineMapper
    {
        public static UnpaidFineDTO FromProjection(UnpaidFineProjection projection)
        {
            return new UnpaidFineDTO
            {
              FineRecordID = projection.FineRecordID,
              LateDays=projection.LateDays,
              AmountDue=projection.AmountDue,
              DateAdded=projection.DateAdded

            };
        }


        public static List<UnpaidFineDTO> FromProjectionList(List<UnpaidFineProjection> projections)
        {
            return projections.Select(FromProjection).ToList();
        }



    }
}
