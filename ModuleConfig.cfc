component {

    this.title  = "config-builder";
    this.author = "Joseph Lamoree";
    this.webURL = "https://github.com/ecivis/config-builder";
    this.description = "A custom DSL for fetching nested configuration information.";
    this.version = "1.0.0";
    this.dependencies = [];
    this.autoMapModels = false;

    /**
    * Configure
    */
    public void function configure() {
        // You might like to know that this will get called multiple times. For reasons, I guess.
        variables.log.info("The Config Builder module was configured.");

        /*
        This doesn't work:
        variables.binder.mapDSL("config", "#variables.moduleMapping#.ConfigBuilderDSL");
        */

        /*
        This also doesn't work:
        if (!structKeyExists(variables.wirebox, "customDSL")) {
            variables.wirebox.customDSL = {};
        }
        structAppend(variables.wirebox.customDSL, {"config": "#variables.moduleMapping#.ConfigBuilderDSL"});
        */

        /*
        This works. Perhaps dynamic DSL registration is required due to load order.
        */
        variables.controller.getWireBox().registerDSL("config", "#variables.moduleMapping#.ConfigBuilderDSL");
    }

    /**
    * Fired when the module is registered and activated.
    */
    public void function onLoad() {
    }

    /**
    * Fired when the module is unregistered and unloaded
    */
    public void function onUnload() {
    }

}