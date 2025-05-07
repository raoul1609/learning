
const Category = require ('../models/category_model')

exports.getCategories = async (req, res) => {
    try {
      const users = await Category.get_categories();
      res.json(users);
    } catch (err) {
        console.log(err);
        res.status(500).send('Erreur lors de la connection a la base de donnees');
      //res.status.send(err);

    }
};

exports.getCategoryById = async (req, res) => {
    try {
      const user = await Category.get_category_by_id(req.params.id);
      if (!user) {
        return res.status(404).send('Category not found');
      }
      res.json(user);
    } catch (err) {
      res.status(500).send('Server error');
    }
};
  

exports.createCategory = async (req, res) => {
    try {
      const { name} = req.body;
      const id = await Category.create_categories(name);
      res.status(201).json({ id, name });
    } catch (err) {
        console.log(err)
        res.status(500).send('Server error');
    }
};

exports.updateCategory = async (req, res) => {
    try {
      const { name } = req.body;
      await Category.update_category(req.params.id, name);
      res.status(200).send('Category updated');
    } catch (err) {
      res.status(500).send('Server error');
    }
};