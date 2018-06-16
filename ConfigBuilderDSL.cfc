/**
 * This implements coldbox.system.ioc.dsl.IDSLBuilder, but we can't specify that because CFML OMG WTF.
 */
component {

    /**
    * @injector Typically an instance of coldbox.system.ioc.Injector. Almost 100% of the time.
    */
    public any function init(required any injector) {
        variables.injector = arguments.injector;
        variables.coldbox = variables.injector.getColdBox();
        variables.log = variables.injector.getLogBox().getLogger(this);

        if (variables.log.canDebug()) {
            variables.log.debug("Configured the Config Builder custom DSL.");
        }

        return this;
    }

    /**
    * @definition If this isn't a struct, you'll have a bad time.
    * @targetObject Not expected or used by this builder.
    */
    public any function process(required any definition, any targetObject) {
        var locator = arguments.definition.dsl.replace("config:", "");
        var depth = locator.listLen(".");
        var top = "";
        var matches = [];
        var match = "";

        if (variables.keyExists("log") && variables.log.canDebug()) {
            variables.log.debug("Received DSL definition '#arguments.definition.dsl#'");
        }

        if (locator.len() == 0 || depth == 0) {
            throw(type="InvalidDSLException", message="The specified DSL ('#arguments.definition.dsl#') does not contain a locator.");
        } else if (depth == 1) {
            if (variables.coldbox.settingExists(locator)) {
                return variables.coldbox.getSetting(locator);
            } else {
                throw(type="SettingNotFoundException", message="The requested ColdBox setting was not found for DSL '#arguments.definition.dsl#'.");
            }
        }

        if (variables.coldbox.settingExists(listFirst(locator, "."))) {
            top = variables.coldbox.getSetting(listFirst(locator, "."));
        } else {
            throw(type="SettingNotFoundException", message="The top level ColdBox setting was not found for DSL '#arguments.definition.dsl#'.");
        }

        matches = top.findKey(locator.listLast("."), "all");
        if (matches.len() == 0) {
            throw(type="SettingNotFoundException", message="A nested ColdBox setting was not found for DSL '#arguments.definition.dsl#'.");
        }
        locator = "." & locator.listRest(".");
        for (match in matches) {
            if (match.path == locator) {
                return match.value;
            }
        }
        throw(type="SettingNotFoundException", message="The requested ColdBox setting was not found for DSL '#arguments.definition.dsl#'.");
    }

}