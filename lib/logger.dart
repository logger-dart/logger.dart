/// Package provides simple, yet efficient structured logger.

export 'src/package.dart'
    show
        Record,
        Tracer,
        LogHandler,
        Interface,
        Logger,
        Level,

        // default logger related things
        defaultLogger,
        level,
        addHandler,
        close,
        log,
        debug,
        info,
        warning,
        error,
        fatal,
        trace,
        withFields,
        withField;
