class ExpenseTracker {
            constructor() {
                this.transactions = [];
                this.currentType = 'income';
                this.incomeCategories = [
                    'Salary', 'Freelance', 'Business', 'Investment', 
                    'Rental', 'Gift', 'Other Income'
                ];
                this.expenseCategories = [
                    'Food & Dining', 'Transportation', 'Entertainment', 
                    'Shopping', 'Bills & Utilities', 'Healthcare', 
                    'Education', 'Travel', 'Personal Care', 'Other Expenses'
                ];
                
                this.initializeEventListeners();
                this.updateCategories();
                this.setCurrentDate();
                this.updateDisplay();
            }

            initializeEventListeners() {
                // Type selection buttons
                document.getElementById('incomeBtn').addEventListener('click', () => {
                    this.switchTransactionType('income');
                });
                
                document.getElementById('expenseBtn').addEventListener('click', () => {
                    this.switchTransactionType('expense');
                });

                // Form submission
                document.getElementById('transactionForm').addEventListener('submit', (e) => {
                    e.preventDefault();
                    this.addTransaction();
                });

                // Clear all transactions
                document.getElementById('clearAllBtn').addEventListener('click', () => {
                    this.clearAllTransactions();
                });
            }

            switchTransactionType(type) {
                this.currentType = type;
                
                const incomeBtn = document.getElementById('incomeBtn');
                const expenseBtn = document.getElementById('expenseBtn');
                
                if (type === 'income') {
                    incomeBtn.classList.add('active');
                    expenseBtn.classList.remove('active');
                } else {
                    expenseBtn.classList.add('active');
                    incomeBtn.classList.remove('active');
                }
                
                this.updateCategories();
                this.hideMessages();
            }

            updateCategories() {
                const categorySelect = document.getElementById('category');
                const categories = this.currentType === 'income' ? this.incomeCategories : this.expenseCategories;
                
                categorySelect.innerHTML = '<option value="">Select Category</option>';
                categories.forEach(category => {
                    const option = document.createElement('option');
                    option.value = category;
                    option.textContent = category;
                    categorySelect.appendChild(option);
                });
            }

            setCurrentDate() {
                const today = new Date().toISOString().split('T')[0];
                document.getElementById('date').value = today;
            }

            validateForm() {
                const date = document.getElementById('date').value;
                const description = document.getElementById('description').value.trim();
                const category = document.getElementById('category').value;
                const amount = document.getElementById('amount').value;

                if (!date) {
                    this.showError('Please select a date');
                    return false;
                }

                if (!description) {
                    this.showError('Please enter a description');
                    return false;
                }

                if (description.length < 3) {
                    this.showError('Description must be at least 3 characters long');
                    return false;
                }

                if (!category) {
                    this.showError('Please select a category');
                    return false;
                }

                if (!amount || amount <= 0) {
                    this.showError('Please enter a valid amount greater than 0');
                    return false;
                }

                if (amount > 999999999) {
                    this.showError('Amount cannot exceed ₹999,999,999');
                    return false;
                }

                const selectedDate = new Date(date);
                const today = new Date();
                const oneYearFromNow = new Date();
                oneYearFromNow.setFullYear(today.getFullYear() + 1);

                if (selectedDate > oneYearFromNow) {
                    this.showError('Date cannot be more than one year in the future');
                    return false;
                }

                return true;
            }

            addTransaction() {
                if (!this.validateForm()) {
                    return;
                }

                const date = document.getElementById('date').value;
                const description = document.getElementById('description').value.trim();
                const category = document.getElementById('category').value;
                const amount = parseFloat(document.getElementById('amount').value);

                const transaction = {
                    id: Date.now(),
                    date: date,
                    description: description,
                    category: category,
                    amount: amount,
                    type: this.currentType
                };

                this.transactions.unshift(transaction); // Add to beginning of array
                this.clearForm();
                this.updateDisplay();
                this.showSuccess(`${this.currentType === 'income' ? 'Income' : 'Expense'} of ₹${amount.toFixed(2)} added successfully!`);
            }

            deleteTransaction(id) {
                if (confirm('Are you sure you want to delete this transaction?')) {
                    this.transactions = this.transactions.filter(transaction => transaction.id !== id);
                    this.updateDisplay();
                    this.showSuccess('Transaction deleted successfully!');
                }
            }

            clearAllTransactions() {
                if (this.transactions.length === 0) {
                    this.showError('No transactions to clear');
                    return;
                }
                
                if (confirm('Are you sure you want to delete all transactions? This action cannot be undone.')) {
                    this.transactions = [];
                    this.updateDisplay();
                    this.showSuccess('All transactions cleared successfully!');
                }
            }

            clearForm() {
                document.getElementById('description').value = '';
                document.getElementById('category').value = '';
                document.getElementById('amount').value = '';
                this.setCurrentDate();
            }

            updateDisplay() {
                this.updateSummaryCards();
                this.displayTransactions();
            }

            updateSummaryCards() {
                const totalIncome = this.transactions
                    .filter(t => t.type === 'income')
                    .reduce((sum, t) => sum + t.amount, 0);

                const totalExpense = this.transactions
                    .filter(t => t.type === 'expense')
                    .reduce((sum, t) => sum + t.amount, 0);

                const netBalance = totalIncome - totalExpense;

                document.getElementById('totalIncome').textContent = `₹${totalIncome.toFixed(2)}`;
                document.getElementById('totalExpense').textContent = `₹${totalExpense.toFixed(2)}`;
                document.getElementById('netBalance').textContent = `₹${netBalance.toFixed(2)}`;

                // Update balance color based on positive/negative
                const balanceElement = document.getElementById('netBalance');
                const balanceCard = balanceElement.closest('.card');
                
                if (netBalance >= 0) {
                    balanceElement.style.color = '#4CAF50';
                    balanceCard.style.borderLeftColor = '#4CAF50';
                } else {
                    balanceElement.style.color = '#f44336';
                    balanceCard.style.borderLeftColor = '#f44336';
                }
            }

            displayTransactions() {
                const transactionList = document.getElementById('transactionList');
                const noTransactions = document.getElementById('noTransactions');

                if (this.transactions.length === 0) {
                    transactionList.innerHTML = '';
                    transactionList.appendChild(noTransactions);
                    return;
                }

                transactionList.innerHTML = '';

                this.transactions.forEach(transaction => {
                    const transactionElement = this.createTransactionElement(transaction);
                    transactionList.appendChild(transactionElement);
                });
            }

            createTransactionElement(transaction) {
                const div = document.createElement('div');
                div.className = 'transaction-item';
                
                const formattedDate = new Date(transaction.date).toLocaleDateString('en-IN', {
                    year: 'numeric',
                    month: 'short',
                    day: 'numeric'
                });

                div.innerHTML = `
                    <div class="transaction-indicator ${transaction.type}"></div>
                    <div class="transaction-info">
                        <h4>${transaction.description}</h4>
                        <p>${formattedDate}</p>
                    </div>
                    <div class="transaction-category">${transaction.category}</div>
                    <div class="transaction-amount ${transaction.type}">
                        ${transaction.type === 'income' ? '+' : '-'}₹${transaction.amount.toFixed(2)}
                    </div>
                    <button class="delete-btn" onclick="tracker.deleteTransaction(${transaction.id})">×</button>
                `;

                return div;
            }

            showError(message) {
                this.hideMessages();
                const errorDiv = document.getElementById('errorMessage');
                errorDiv.textContent = message;
                errorDiv.style.display = 'block';
                
                setTimeout(() => {
                    this.hideMessages();
                }, 5000);
            }

            showSuccess(message) {
                this.hideMessages();
                const successDiv = document.getElementById('successMessage');
                successDiv.textContent = message;
                successDiv.style.display = 'block';
                
                setTimeout(() => {
                    this.hideMessages();
                }, 3000);
            }

            hideMessages() {
                document.getElementById('errorMessage').style.display = 'none';
                document.getElementById('successMessage').style.display = 'none';
            }
        }

        // Initialize the expense tracker when the page loads
        const tracker = new ExpenseTracker();