const pool = require('./../db');

class Category {

    static async get_categories() {
        const [rows] = await pool.query('SELECT * FROM blog_categories');
        return rows;
    }

    static async get_category_by_id(id) {
        const [rows] = await pool.query('SELECT * FROM blog_categories WHERE id = ?', [id]);
        return rows[0];
    }

    static async create_categories(name) {
        const [result] = await pool.query(
          'INSERT INTO blog_categories (name) VALUES (?)',
          [name]
        );
        return result.insertId;
    }

    static async update_category(id, name) {
        await pool.query(
          'UPDATE blog_categories SET name = ?  WHERE id = ?',
          [name, email, id]
        );
      }
    
      static async delete_category(id) {
        await pool.query('DELETE FROM blog_categories WHERE id = ?', [id]);
      }
}

module.exports = Category ;