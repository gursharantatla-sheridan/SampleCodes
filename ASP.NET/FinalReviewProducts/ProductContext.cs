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
        modelBuilder.Entity<Category>().HasData(
            new Category { CategoryId = 1, CategoryName = "Electronics" },
            new Category { CategoryId = 2, CategoryName = "Clothing" },
            new Category { CategoryId = 3, CategoryName = "Appliances" },
            new Category { CategoryId = 4, CategoryName = "Books" },
            new Category { CategoryId = 5, CategoryName = "Sports Equipment" }
        );

        modelBuilder.Entity<Product>().HasData(
            new Product
            {
                ProductId = 1,
                ProductName = "Smartphone",
                CategoryId = 1
            },
            new Product
            {
                ProductId = 2,
                ProductName = "Laptop",
                CategoryId = 1
            },
            new Product
            {
                ProductId = 3,
                ProductName = "Jacket",
                CategoryId = 2
            },
            new Product
            {
                ProductId = 4,
                ProductName = "Microwave",
                CategoryId = 3
            },
            new Product
            {
                ProductId = 5,
                ProductName = "Fiction Novel",
                CategoryId = 4
            },
            new Product
            {
                ProductId = 6,
                ProductName = "Tennis Racket",
                CategoryId = 5
            }
        );
    }

    // -------- TO HERE --------
}
