using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;
using PatronPortal_BusinessLogicLayer.Mappers;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;
using PatronPortal_DataAccessLayer.Repositories.Projections;


namespace PatronPortal_BusinessLogicLayer.Implementations
{
    public  class Fine:IFine
    {
        private readonly IFineRepo _repo;

        public Fine(IFineRepo repo)
        {
            _repo = repo;
        }

        public async Task<Dictionary<string, List<UnpaidFineDTO>>> GetUnpaidFines(int MemberRecordId) 
        {
        
         var projections=await _repo.GetUnpaidFines(MemberRecordId);
         var unpaidFines=UnpaidFineMapper.FromProjectionList(projections);

         return new Dictionary<string, List<UnpaidFineDTO>> { ["fines"]=unpaidFines};



        }

    }
}
