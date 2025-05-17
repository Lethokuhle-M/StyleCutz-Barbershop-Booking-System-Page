using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(StyleCutzBarberShopWebApp.Startup))]
namespace StyleCutzBarberShopWebApp
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
