# Configuration model

- Define one typed config struct per service boundary. Parse once at startup
  and pass typed values inward.
- Keep configuration immutable after startup unless live reload is explicitly
  required and tested.
- Keep configuration loading at the application boundary. Adapters receive
  only the values they need through constructors.
