#ifndef STRUCTURE_HPP
#define STRUCTURE_HPP

// tentative definition of a general data structure class. TODO adapt it
class Structure {
    
    template<class K, class V>
    int insert(K key, V value);

    template<class K, class V>
    int update(K key, V value);

    template<class K, class V>
    V lookup(K key);

    template<class K>
    V* lookup_range(K start, K end);

    template<class K>
    int remove(K key);
}

#endif
