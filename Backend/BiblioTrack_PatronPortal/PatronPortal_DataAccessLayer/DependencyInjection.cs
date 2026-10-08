using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using PatronPortal_DataAccessLayer.Context;
using PatronPortal_DataAccessLayer.Entities;
using PatronPortal_DataAccessLayer.Repositories.Implementations;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;

namespace PatronPortal_DataAccessLayer
{
    public static class DependencyInjection
    {
        public static IServiceCollection RegisterDataAccessLayer(this IServiceCollection services,IConfiguration configuration)
        {
            services.AddDbContext<BiblioTrackv1Context>(options =>
                options.UseSqlServer(configuration.GetConnectionString("BiblioTrackv1")!));

            //
            services.AddScoped<IAuthRepo, AuthRepo>();
            services.AddScoped<IPasswordRecoveryRepo, PasswordRecoveryRepo>();
            services.AddScoped<IPatronRegisterationRepo, PatronRegisterationRepo>();
            services.AddScoped<IPatronFavoritesRepo, PatronFavoritesRepo>();
            services.AddScoped<IBookRepo, BookRepo>();
            services.AddScoped<IPatronRecommendationRepo, PatronRecommendationRepo>();
            services.AddScoped<INotificationSummaryRepo, NotificationSummaryRepo>();
            services.AddScoped<IPatronNotificationsRepo, PatronNotificationsRepo>();
            services.AddScoped<IBookReservationRepo, BookReservationRepo>();
            services.AddScoped<ILibraryCardRepo, LibraryCardRepo>();
            services.AddScoped<IFineRepo, FineRepo>();
            services.AddScoped<IPaymentRepo, PaymentRepo>();
            return services;
        }
    }
}
