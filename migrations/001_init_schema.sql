-- Клиенты
CREATE TABLE customers (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    phone TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Магазины
CREATE TABLE stores (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT NOT NULL
);

-- Продукты
CREATE TABLE products (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL CHECK (price > 0),
    category TEXT
);

-- Склады
CREATE TABLE inventories (
    store_id UUID REFERENCES stores(id),
    product_id UUID REFERENCES products(id),
    quantity INT NOT NULL CHECK (quantity >= 0),
    last_restock_date DATE,
    PRIMARY KEY (store_id, product_id)
);

-- Заказы
CREATE TABLE orders (
    id UUID PRIMARY KEY,
    customer_id UUID REFERENCES customers(id),
    store_id UUID REFERENCES stores(id),
    order_date TIMESTAMP DEFAULT NOW(),
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'cancelled'))
);

ALTER TABLE orders ALTER COLUMN id SET DEFAULT gen_random_uuid();

-- Элементы заказов
CREATE TABLE order_items (
    order_id UUID REFERENCES orders(id),
    product_id UUID REFERENCES products(id),
    quantity INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (order_id, product_id)
);