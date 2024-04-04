/*
* @details: modified to evaluate the datastructures instead of databases.
*
* @author: Cristian Sandu <cristian.sandu@tum.de>
*/

#include "basic_db.h"
#include "core/db_factory.h"

#include <dlfcn.h>
#include <cstring>

namespace {
  const std::string PROP_SILENT = "basic.silent";
  const std::string PROP_SILENT_DEFAULT = "false";

  /* initialize the datastructure */
  const std::string LIB_PATH    = "libpath";
}

namespace ycsbc {

std::mutex BasicDB:: mutex_;

int BasicDB::Init() {
  /* initialize the datastructure */
  std::lock_guard<std::mutex> lock(mutex_);

  this->libpath   = this->props_->GetProperty(LIB_PATH, "none");
  this->libhandle = dlopen(this->libpath.c_str(), RTLD_LAZY);
  if (this->libhandle == nullptr) {
    std::cerr << "unable to load the library " << this->libpath  << "reason: " << dlerror() << std::endl;
    return 1;
  }

  /* load the functions */
  this->ds_init   = (void* (*)())dlsym(this->libhandle,  "ds_init");
  if (this->ds_init == nullptr) {
    std::cerr << "unable to load the function ds_init from the library " << this->libpath << std::endl;
    return 1;
  }

  this->ds_insert = (int (*)(void*, uint64_t, uint64_t))dlsym(this->libhandle, "ds_insert");
  if (this->ds_insert == nullptr) {
    std::cerr << "unable to load the function ds_insert from the library " << this->libpath << std::endl;
    return 1;
  }

  this->ds_remove = (int (*)(void*, uint64_t))dlsym(this->libhandle, "ds_remove");
  if (this->ds_remove == nullptr) {
    std::cerr << "unable to load the function ds_remove from the library " << this->libpath << std::endl;
    return 1;
  }

  this->ds_read = (int (*)(void*, uint64_t))dlsym(this->libhandle, "ds_read");
  if (this->ds_remove == nullptr) {
    std::cerr << "unable to load the function ds_read from the library " << this->libpath << std::endl;
    return 1;
  }

  this->ds_read_range = (int (*)(void*, uint64_t, uint64_t))dlsym(this->libhandle, "ds_read_range");
  if (this->ds_remove == nullptr) {
    std::cerr << "unable to load the function ds_read_range from the library " << this->libpath << std::endl;
    return 1;
  }
  this->generic_structure = this->ds_init();
  return 0;
}

DB::Status BasicDB::Read(const std::string &table, const uint64_t key) {
  std::lock_guard<std::mutex> lock(mutex_);
  return kOK;
}

DB::Status BasicDB::Scan(const std::string &table, const uint64_t key, int len) {
  std::lock_guard<std::mutex> lock(mutex_);
  int result = this->ds_read_range(this->generic_structure, key, len);
  if (result == 0) {
    return kOK;
  }
  return kError;
}

DB::Status BasicDB::Update(const std::string &table, const uint64_t key,
                           const uint64_t value) {
  /* update is equivalent to insert */
  std::lock_guard<std::mutex> lock(mutex_);
  int result = this->ds_insert(this->generic_structure, key, value);
  if (result == 0) {
    return kOK;
  }
  return kError;
}

DB::Status BasicDB::Insert(const std::string &table, const uint64_t key, uint64_t value) {
  std::lock_guard<std::mutex> lock(mutex_);
  int result = this->ds_insert(this->generic_structure, key, value);
  if (result == 0) {
    return kOK;
  }
  return kError;
}

DB::Status BasicDB::Delete(const std::string &table, uint64_t key) {
  std::lock_guard<std::mutex> lock(mutex_);
  int result = this->ds_remove(this->generic_structure, key);
  if (result == 0) {
    return kOK;
  }
  exit(1);
  return kError;
}

DB *NewBasicDB() {
  return new BasicDB;
}

const bool registered = DBFactory::RegisterDB("basic", NewBasicDB);

} // ycsbc
