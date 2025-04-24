CREATE DATABASE E_Commerce;
USE E_Commerce;

-- brand --
CREATE TABLE brand (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    logo_url VARCHAR(255)
);
INSERT INTO brand (name, description, logo_url) VALUES
('Mercedes-Benz', 'Luxury automobile manufacturer from Germany', 'mercedes_logo.png'),
('BMW', 'Bavarian luxury vehicle and motorcycle manufacturer', 'bmw_logo.png'),
('Audi', 'German automobile manufacturer specializing in luxury vehicles', 'audi_logo.png'),
('Porsche', 'German high-performance sports car manufacturer', 'porsche_logo.png'),
('Volkswagen', 'German automobile manufacturer founded in 1937', 'vw_logo.png');

-- product_category --
CREATE TABLE product_category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_category_id INT,
    FOREIGN KEY (parent_category_id) REFERENCES product_category(category_id)
);
INSERT INTO product_category (name, description, parent_category_id) VALUES
('Vehicles', 'All types of automobiles', NULL),
('Sedans', 'Four-door passenger cars', 1),
('SUVs', 'Sport utility vehicles', 1),
('Coupes', 'Two-door sporty cars', 1),
('Convertibles', 'Cars with retractable roofs', 1),
('Electric Vehicles', 'Battery-powered vehicles', 1),
('Luxury Sedans', 'Premium four-door cars', 2),
('Compact SUVs', 'Smaller sport utility vehicles', 3),
('Sports Coupes', 'High-performance two-door cars', 4);

-- color --
CREATE TABLE color (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    hex_code VARCHAR(7)
);
INSERT INTO color (name, hex_code) VALUES
('Alpine White', '#FFFFFF'),
('Obsidian Black', '#000000'),
('Moonlight Blue', '#1A365D'),
('Brilliant Silver', '#C0C0C0'),
('Mars Red', '#A52A2A'),
('Emerald Green', '#046307'),
('Tanzanite Blue', '#242E4C'),
('Mojave Beige', '#D6CFC7'),
('Selenite Grey', '#708090');

-- size_category --
CREATE TABLE size_category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description TEXT
);
INSERT INTO size_category (name, description) VALUES
('Engine Size', 'Engine displacement in liters'),
('Wheel Size', 'Wheel diameter in inches'),
('Vehicle Class', 'Size category of vehicle'),
('Seating Capacity', 'Number of passenger seats');

-- size_option --
CREATE TABLE size_option (
    size_option_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT,
    name VARCHAR(20) NOT NULL,
    order_sequence INT,
    FOREIGN KEY (category_id) REFERENCES size_category(category_id)
);
INSERT INTO size_option (category_id, name, order_sequence) VALUES
(1, '2.0L', 1),
(1, '3.0L', 2),
(1, '4.0L', 3),
(1, '5.0L', 4),
(1, '6.0L', 5),
(2, '17"', 1),
(2, '18"', 2),
(2, '19"', 3),
(2, '20"', 4),
(2, '21"', 5),
(3, 'Compact', 1),
(3, 'Mid-size', 2),
(3, 'Full-size', 3),
(3, 'Executive', 4),
(4, '2', 1),
(4, '4', 2),
(4, '5', 3),
(4, '7', 4);

-- attribute_category --
CREATE TABLE attribute_category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT
);
INSERT INTO attribute_category (name, description) VALUES
('Performance', 'Vehicle performance specifications'),
('Safety', 'Safety features and ratings'),
('Technology', 'Tech and infotainment features'),
('Comfort', 'Interior comfort features'),
('Efficiency', 'Fuel efficiency and eco-features');

-- attribute_type --
CREATE TABLE attribute_type (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    data_type ENUM('text', 'number', 'boolean', 'date')
);
INSERT INTO attribute_type (name, data_type) VALUES
('Horsepower', 'number'),
('Acceleration', 'number'),
('Safety Rating', 'number'),
('Release Year', 'date'),
('Feature Description', 'text'),
('Available', 'boolean');

-- Product --
CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    brand_id INT,
    category_id INT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    base_price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);
INSERT INTO product (brand_id, category_id, name, description, base_price) VALUES
(1, 7, 'Mercedes-Benz S-Class', 'Flagship luxury sedan with cutting-edge technology and supreme comfort', 94250.00),
(1, 3, 'Mercedes-Benz GLE', 'Mid-size luxury SUV with powerful performance and elegant design', 56750.00),
(2, 7, 'BMW 7 Series', 'Executive sedan offering the ultimate in luxury and innovative technology', 86800.00),
(2, 9, 'BMW 8 Series', 'Luxury grand tourer combining high performance with elegant styling', 99900.00),
(3, 7, 'Audi A8', 'Full-size luxury sedan with advanced technology and sophisticated design', 86500.00),
(3, 8, 'Audi Q5', 'Compact luxury crossover SUV with versatile performance', 45600.00),
(4, 9, 'Porsche 911', 'Iconic high-performance sports car with distinctive styling', 101200.00),
(4, 3, 'Porsche Cayenne', 'Luxury SUV combining sports car performance with utility', 69000.00),
(5, 6, 'Volkswagen ID.4', 'All-electric compact SUV with modern design and tech', 41230.00),
(5, 2, 'Volkswagen Arteon', 'Premium fastback sedan with sleek styling and upscale features', 36995.00);

-- product_variation --
CREATE TABLE product_variation (
    variation_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    size_option_id INT,
    color_id INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id)
);
INSERT INTO product_variation (product_id, size_option_id, color_id) VALUES
(1, 2, 1),
(1, 3, 2),
(2, 2, 4),
(2, 3, 6),
(3, 3, 2),
(3, 4, 7), 
(4, 3, 1),
(4, 4, 5),
(5, 3, 9), 
(5, 2, 8),
(6, 1, 3),
(6, 2, 4),
(7, 2, 5),
(7, 3, 2),
(8, 2, 1),
(8, 3, 9),
(9, 1, 6), 
(9, 1, 1),
(10, 1, 4),
(10, 1, 3);

-- product_item --
CREATE TABLE product_item (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    variation_id INT,
    SKU VARCHAR(50) UNIQUE,
    price DECIMAL(10,2),
    stock_quantity INT,
    status ENUM('active', 'inactive', 'out_of_stock'),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (variation_id) REFERENCES product_variation(variation_id)
);
INSERT INTO product_item (product_id, variation_id, SKU, price, stock_quantity, status) VALUES
(1, 1, 'MB-S450-WHT', 94250.00, 12, 'active'),
(1, 2, 'MB-S580-BLK', 116450.00, 8, 'active'),
(2, 3, 'MB-GLE450-SLV', 56750.00, 15, 'active'),
(2, 4, 'MB-GLE63-GRN', 76950.00, 3, 'active'),
(3, 5, 'BMW-740i-BLK', 86800.00, 10, 'active'),
(3, 6, 'BMW-760i-BLUE', 113600.00, 5, 'active'),
(4, 7, 'BMW-840i-WHT', 99900.00, 7, 'active'),
(4, 8, 'BMW-M850i-RED', 122900.00, 4, 'active'),
(5, 9, 'AUDI-A8-GRY', 86500.00, 9, 'active'),
(5, 10, 'AUDI-A8-BEG', 86500.00, 6, 'active'),
(6, 11, 'AUDI-Q5-BLU', 45600.00, 18, 'active'),
(6, 12, 'AUDI-SQ5-SLV', 55300.00, 11, 'active'),
(7, 13, 'POR-911-RED', 101200.00, 6, 'active'),
(7, 14, 'POR-911T-BLK', 118300.00, 3, 'active'),
(8, 15, 'POR-CAYN-WHT', 69000.00, 9, 'active'),
(8, 16, 'POR-CAYTS-GRY', 89000.00, 5, 'active'),
(9, 17, 'VW-ID4-GRN', 41230.00, 22, 'active'),
(9, 18, 'VW-ID4-WHT', 41230.00, 25, 'active'),
(10, 19, 'VW-ART-SLV', 36995.00, 14, 'active'),
(10, 20, 'VW-ART-BLU', 36995.00, 11, 'active');

-- product_image --
CREATE TABLE product_image (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    image_url VARCHAR(255) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    display_order INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);
INSERT INTO product_image (product_id, image_url, is_primary, display_order) VALUES
(1, 'mercedes_sclass_white_front.jpg', TRUE, 1),
(1, 'mercedes_sclass_white_interior.jpg', FALSE, 2),
(1, 'mercedes_sclass_black_front.jpg', FALSE, 3),
(2, 'mercedes_gle_silver_front.jpg', TRUE, 1),
(2, 'mercedes_gle_green_side.jpg', FALSE, 2),
(3, 'bmw_7series_black_front.jpg', TRUE, 1),
(3, 'bmw_7series_blue_side.jpg', FALSE, 2),
(4, 'bmw_8series_white_front.jpg', TRUE, 1),
(4, 'bmw_8series_red_side.jpg', FALSE, 2),
(5, 'audi_a8_grey_front.jpg', TRUE, 1),
(5, 'audi_a8_beige_interior.jpg', FALSE, 2),
(6, 'audi_q5_blue_front.jpg', TRUE, 1),
(6, 'audi_q5_silver_rear.jpg', FALSE, 2),
(7, 'porsche_911_red_front.jpg', TRUE, 1),
(7, 'porsche_911_black_side.jpg', FALSE, 2),
(8, 'porsche_cayenne_white_front.jpg', TRUE, 1),
(8, 'porsche_cayenne_grey_interior.jpg', FALSE, 2),
(9, 'vw_id4_green_front.jpg', TRUE, 1),
(9, 'vw_id4_white_side.jpg', FALSE, 2),
(10, 'vw_arteon_silver_front.jpg', TRUE, 1),
(10, 'vw_arteon_blue_rear.jpg', FALSE, 2);

-- attribute_type --
CREATE TABLE product_attribute (
    attribute_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    category_id INT,
    type_id INT,
    attribute_value TEXT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (category_id) REFERENCES attribute_category(category_id),
    FOREIGN KEY (type_id) REFERENCES attribute_type(type_id)
);
INSERT INTO product_attribute (product_id, category_id, type_id, attribute_value) VALUES
(1, 1, 1, '362'), -- S-Class horsepower base model
(1, 1, 2, '5.4'), -- S-Class 0-60 mph in seconds
(1, 2, 3, '5'), -- S-Class safety rating
(1, 3, 5, 'MBUX infotainment system with AI, augmented reality navigation'),
(1, 4, 5, 'Heated and ventilated seats with massage function'),
(2, 1, 1, '362'), -- GLE horsepower
(2, 2, 5, 'Active Brake Assist, Blind Spot Assist, 360-degree camera'),
(2, 4, 5, 'Heated front and rear seats, 64-color ambient lighting'),
(3, 1, 1, '335'), -- BMW 7 Series base horsepower
(3, 3, 5, 'BMW iDrive 8.0 with 14.9-inch curved display'),
(3, 4, 5, 'Four-zone climate control, power rear sunshades'),
(4, 1, 1, '523'), -- BMW 8 Series M850i
(4, 1, 2, '3.7'), -- 0-60 mph
(4, 3, 5, 'Digital dashboard with head-up display, wireless charging'),
(5, 3, 5, 'MMI touch response system with dual touchscreens'),
(5, 4, 5, 'Valcona leather seats with 22-way power adjustment'),
(6, 1, 1, '261'), -- Audi Q5 base horsepower
(6, 5, 5, '24 mpg city, 31 mpg highway'),
(7, 1, 1, '379'), -- Porsche 911 Carrera base
(7, 1, 2, '3.9'), -- 0-60 mph
(7, 3, 5, 'Porsche Communication Management with 10.9-inch touchscreen'),
(8, 1, 1, '335'), -- Porsche Cayenne base
(8, 2, 5, 'Porsche Active Safe with automatic emergency braking'),
(9, 5, 5, '104 MPGe combined, 250-mile range'),
(9, 3, 5, 'ID. Cockpit with 12-inch touchscreen, wireless App-Connect'),
(10, 1, 1, '268'), -- VW Arteon
(10, 5, 5, '22 mpg city, 31 mpg highway');


