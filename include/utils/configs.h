#ifndef _CONFIGS_H_
#define _CONFIGS_H_

typedef enum {IN_ORDER = 0, RANDOM_SHUFFLE = 1} ITEM_ORDER;

template <typename ...T>
auto generate_configurations(ITEM_ORDER ord, std::vector<T>& ...is) {

	auto confs = cross(is...);
	if (ord == RANDOM_SHUFFLE) {
		std::cout << "ord = RANDOM_SHUFFLE" << std::endl;
		std::srand ( unsigned ( std::time(0) ) );
		std::shuffle ( confs.begin(), confs.end(), std::mt19937{std::random_device{}()});
	}
	return confs;
}

#endif