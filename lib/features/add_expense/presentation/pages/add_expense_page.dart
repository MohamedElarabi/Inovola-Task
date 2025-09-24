import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../expense/presentation/bloc/expense_bloc.dart';
import '../../../expense/presentation/bloc/expense_event.dart';
import '../../../expense/presentation/bloc/expense_state.dart';
import '../../../expense/domain/entities/category.dart';
import '../widgets/category_selector.dart';
import '../widgets/currency_dropdown.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedCategory = 'Entertainment';
  String _selectedCurrency = 'USD';
  DateTime _selectedDate = DateTime.now();
  String? _receiptPath;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Expense',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocListener<ExpenseBloc, ExpenseState>(
        listener: (context, state) {
          if (state is ExpenseAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Expense added successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is ExpenseError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Categories Dropdown
                _buildSectionTitle('Categories'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    hintText: 'Entertainment',
                  ),
                  items: Category.defaultCategories.map((category) => DropdownMenuItem(
                      value: category.name,
                      child: Text(category.name),
                    )).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),

                const SizedBox(height: 24),

                // Amount Field
                _buildSectionTitle('Amount'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: '\$50,000',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Date Field
                _buildSectionTitle('Date'),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _selectDate,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      hintText: '02/01/24',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    child: Text(
                      '${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year.toString().substring(2)}',
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Currency Dropdown
                _buildSectionTitle('Currency'),
                const SizedBox(height: 8),
                CurrencyDropdown(
                  selectedCurrency: _selectedCurrency,
                  onCurrencyChanged: (currency) {
                    setState(() {
                      _selectedCurrency = currency;
                    });
                  },
                ),

                const SizedBox(height: 24),

                // Attach Receipt Section
                _buildSectionTitle('Attach Receipt'),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _attachReceipt,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      hintText: 'Upload image',
                      suffixIcon: Icon(Icons.camera_alt),
                    ),
                    child: Text(
                      _receiptPath != null ? 'Receipt attached' : 'Upload image',
                      style: TextStyle(
                        color: _receiptPath != null ? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Categories Grid
                _buildSectionTitle('Categories'),
                const SizedBox(height: 16),
                CategorySelector(
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),

                const SizedBox(height: 40),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _saveExpense,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2196F3),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  Widget _buildSectionTitle(String title) => Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF333333),
      ),
    );

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _attachReceipt() async {
    final picker = ImagePicker();

    // Open gallery (you can also use ImageSource.camera)
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _receiptPath = image.path; // store the actual file path
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Receipt attached successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No receipt selected.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  void _saveExpense() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);
      
      context.read<ExpenseBloc>().add(
        AddExpense(
          category: _selectedCategory,
          amount: amount,
          currency: _selectedCurrency,
          date: _selectedDate,
          receiptPath: _receiptPath,
          description: _descriptionController.text.isEmpty 
              ? null 
              : _descriptionController.text,
        ),
      );
    }
  }
}
