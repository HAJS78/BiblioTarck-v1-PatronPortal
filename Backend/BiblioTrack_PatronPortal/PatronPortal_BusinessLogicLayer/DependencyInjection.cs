
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using PatronPortal_BusinessLogicLayer.Implementations;
using PatronPortal_BusinessLogicLayer.Interfaces;
using PatronPortal_DataAccessLayer;
using PatronPortal_DataAccessLayer.Repositories.Implementations;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;
using Microsoft.Extensions.Http;
using PatronPortal_BusinessLogicLayer.PaymentGateway;



namespace PatronPortal_BusinessLogicLayer
{
    public static class DependencyInjection
    {

        public static IServiceCollection RegisterBusinessLogicLayer(this IServiceCollection services ,IConfiguration configuration)
        {
            services.RegisterDataAccessLayer(configuration);

            
            services.AddScoped<IAuth, Auth>();
            services.AddScoped<IPasswordRecovery,PasswordRecovery>();
            services.AddScoped<IPatronRegisteration, PatronRegisteration>();
            services.AddScoped<IPatronFavorites, PatronFavorites>();
            services.AddScoped<IBook,Book> ();
            services.AddScoped<IPatronRecommendation, PatronRecommendation>();
            services.AddScoped<INotificationSummary, NotificationSummary>();
            services.AddScoped<IPatronNotifications, PatronNotifications>();
            services.AddScoped<IBookReservation, BookReservation>();
            services.AddScoped<ILibraryCard, LibraryCard>();
            services.AddScoped<IFine, Fine>();
             services.AddScoped<IPayment, Payment>();


            services.AddHttpClient<IPaymentGatewayClient, PaymentGatewayClient>(client =>
            {
                client.BaseAddress = new Uri(configuration["PaymentGateway:BaseUrl"]!);
            });


            return services;
        }

    }
}
