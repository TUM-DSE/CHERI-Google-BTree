#pragma once

class structure_interface {
    /* prepare and initialize the structure */
    template<class T>
    T initialize();
    
    /* DRAM Indexes operations */
    template<class K, class V>
    int insert(K key, V value);

    template<class K, class V>
    int update(K key, V value);

    template<class K, class V>
    V lookup(K key);

    template<class K, class V>
    V lookup_range(K start, K end);

    template<class K>
    int remove(K key);
}
