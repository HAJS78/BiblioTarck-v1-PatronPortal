namespace PatronPortal_BusinessLogicLayer.Utilities
{
    public static class NotificationTitleBuilder
    {
        public static string BuildTitle(string notificationType)
        {
            switch (notificationType)
            {

                case "OverdueItems":
                    
                        return "Overdue Item";
                    

                case "ReservedItems":

                        return "Reserved Item Ready";

                default:
                        return "Notification";

            }
        }
    }
}
