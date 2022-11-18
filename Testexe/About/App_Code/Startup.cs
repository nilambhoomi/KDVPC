using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(aspApps.Startup))]
namespace aspApps
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
