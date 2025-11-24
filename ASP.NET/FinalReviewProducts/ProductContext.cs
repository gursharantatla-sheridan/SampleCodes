public class ProductContext : DbContext
{
    // constructor
    public ProductContext(DbContextOptions<ProductContext> options) : base(options)
    {
    }

    // entity sets
    public DbSet<Product> Products { get; set; }
    public DbSet<Category> Categories { get; set; }


    // -------- COPY FROM HERE --------
    
    // data seeding
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Category>().HasData(
            new Category { CategoryId = 1, CategoryName = "Electronics" },
            new Category { CategoryId = 2, CategoryName = "Clothing" },
            new Category { CategoryId = 3, CategoryName = "Home Appliances" },
            new Category { CategoryId = 4, CategoryName = "Books" },
            new Category { CategoryId = 5, CategoryName = "Sports Equipment" }
        );

        modelBuilder.Entity<Product>().HasData(
            new Product
            {
                ProductId = 1,
                ProductName = "Smartphone",
                Price = 999.99,
                IsDiscontinued = false,
                CategoryId = 1
            },
            new Product
            {
                ProductId = 2,
                ProductName = "Laptop",
                Price = 1499.49,
                IsDiscontinued = false,
                CategoryId = 1
            },
            new Product
            {
                ProductId = 3,
                ProductName = "Jacket",
                Price = 120.50,
                IsDiscontinued = false,
                CategoryId = 2
            },
            new Product
            {
                ProductId = 4,
                ProductName = "Microwave",
                Price = 300.00,
                IsDiscontinued = true,
                CategoryId = 3
            },
            new Product
            {
                ProductId = 5,
                ProductName = "Fiction Novel",
                Price = 25.00,
                IsDiscontinued = true,
                CategoryId = 4
            },
            new Product
            {
                ProductId = 6,
                ProductName = "Tennis Racket",
                Price = 180.00,
                IsDiscontinued = false,
                CategoryId = 5
            }
        );
    }

    // -------- TO HERE --------
}
