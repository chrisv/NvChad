local options = {
    -- Built in file matchers
    builtin_matchers = {
        -- Detects Kubernetes files based on content
        kubernetes = { enabled = true },
        cloud_init = { enabled = true }
    },

    -- Additional schemas available in Telescope picker
    schemas = {
        {
            name = "K8s 1.26.3 / Minikube P52",
            uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.26.3-standalone-strict/all.json",
        },
        {
            name = "K8s 1.25.0 / OpenShift 4.12",
            uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.25.0-standalone-strict/all.json",
        },
        {
            name = "K8s 1.26.0 / OpenShift 4.13",
            uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.25.0-standalone-strict/all.json",
        },
    },

    -- Pass any additional options that will be merged in the final LSP config
    lspconfig = {
        cmd = {"yaml-language-server"},
        flags = {
            debounce_text_changes = 150,
        },
        settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
                validate = true,
                format = { enable = true },
                hover = true,
                schemaStore = {
                    enable = true,
                    url = "https://www.schemastore.org/api/json/catalog.json",
                },
                schemaDownload = { enable = true },
                schemas = {},
                trace = { server = "debug" },
            },
        },
    },
}
return options
