using PatronPortal_BusinessLogicLayer.Interfaces;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;


namespace PatronPortal_BusinessLogicLayer.Implementations
{
   public class PasswordRecovery:IPasswordRecovery
    {
       private readonly IPasswordRecoveryRepo _repo;

        public PasswordRecovery(IPasswordRecoveryRepo repo)
        {
            _repo = repo;
        }


        public async Task<Dictionary<string,int>> FindPatronByEmail(string email) 
        {
        
         int id= await _repo.FindPatronByEmail(email);
           
         Dictionary<string,int> dic= new()   {["memberRecordID"]=id 
                
                };


            return dic;
        
        }

        public async Task<bool> UpdatePassword(int memberRecordID, string newPassword) 
        {
        
         bool result=await _repo.UpdatePassword(memberRecordID,newPassword);
         
         return result;
        
        }



    }
}
