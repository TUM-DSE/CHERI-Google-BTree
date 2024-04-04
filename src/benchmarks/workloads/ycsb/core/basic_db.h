/*
* @details: modified to evaluate the datastructures instead of databases.
*
* @author: Cristian Sandu <cristian.sandu@tum.de>
*/

#ifndef YCSB_C_BASIC_DB_H_
#define YCSB_C_BASIC_DB_H_

#include "db.h"
#include "utils/properties.h"

#include <iostream>
#include <string>
#include <mutex>

namespace ycsbc {

class BasicDB : public DB {
 public:
  BasicDB() : out_(nullptr) {}

  int Init();

  Status Read  (const std::string &table, const uint64_t key);

  Status Scan  (const std::string &table, const uint64_t key, int len);

  Status Update(const std::string &table, const uint64_t key, const uint64_t value);

  Status Insert(const std::string &table, const uint64_t key, const uint64_t value);

  Status Delete(const std::string &table, const uint64_t key);

 private:
  static std::mutex mutex_;

  std::ostream *out_;
  
  /* the datastructure pointer */
  void*       libhandle = nullptr;
  void*       generic_structure = nullptr;
  std::string libpath;

  void*       (*ds_init)();
  int         (*ds_insert)(void*, uint64_t, uint64_t);
  int         (*ds_remove)(void*, uint64_t);
  int         (*ds_read)(void*, uint64_t);
  int         (*ds_read_range)(void*, uint64_t, uint64_t);
};

DB *NewBasicDB();

} // ycsbc

#endif // YCSB_C_BASIC_DB_H_

