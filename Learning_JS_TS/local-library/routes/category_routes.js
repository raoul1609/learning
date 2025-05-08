const express = require('express');
const categoryController = require('../controllers/category_controllers');

const router = express.Router();

router.get('/', categoryController.getCategories);
router.get('/:id', categoryController.getCategoryById);
router.post('/create/', categoryController.createCategory);
router.put('/update/:id', categoryController.updateCategory);

module.exports = router;
