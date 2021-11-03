class Big_int{
	public:
		//arguments: size of integer, initial value if Big_int is common unsigned int
		explicit Big_int(size_t size, unsigned initial_value=0);
		//arguments: size of integer, string form of hexadecimal with initial value of Big_int
		Big_int(size_t, size, const char *initial_value);
		Big_int(const Big_int& big_int_to_copy);//copy constructor
		~Big_int();
		
		size_t size() const; //return size of Big_int by unsigned int
		
		const Big_int& operator=(const Big_int& big_int_to_copy);
		friend Big_int operator+(const Big_int& op1, const Big_int& op2);
		friend Big_int operator-(const Big_int& op1, const Big_int& op2);
		friend bool operator==(const Big_int& op1, const Big_int& op2);
		friend bool operator<(const Big_int& op1, const Big_int& op2);
		friend ostream& operator<<(ostream& os, const Big_int& op);
		
	private:
	size_t size_;//size of unsigned array. offset: 0
	unsigned *number_;//pointer points ungiend array with value. offset: 4
};