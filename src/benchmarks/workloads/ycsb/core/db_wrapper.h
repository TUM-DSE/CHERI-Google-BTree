/*
* @details: modified to evaluate the datastructures instead of databases.
*
* @author: Cristian Sandu <cristian.sandu@tum.de>
*/

#ifndef YCSB_C_DB_WRAPPER_H_
#define YCSB_C_DB_WRAPPER_H_

#include <string>
#include <vector>

#include "db.h"
#include "measurements.h"
#include "utils/timer.h"
#include "utils/utils.h"

namespace ycsbc {

class DBWrapper : public DB {
 public:
  DBWrapper(DB *db, Measurements *measurements) : db_(db), measurements_(measurements) {}
  ~DBWrapper() {
    delete db_;
  }
  int Init() {
    return db_->Init();
  }
  void Cleanup() {
    db_->Cleanup();
  }

  Status Read(const std::string &table, const uint64_t key) {
    timer_.Start();
    Status s = db_->Read(table, key);
    uint64_t elapsed = timer_.End();
    if (s == kOK) {
      measurements_->Report(READ, elapsed);
    } else {
      measurements_->Report(READ_FAILED, elapsed);
    }
    return s;
  }

  Status Scan(const std::string &table, const uint64_t key, int len) {
    timer_.Start();
    Status s = db_->Scan(table, key, len);
    uint64_t elapsed = timer_.End();
    if (s == kOK) {
      measurements_->Report(SCAN, elapsed);
    } else {
      measurements_->Report(SCAN_FAILED, elapsed);
    }
    return s;
  }

  Status Update(const std::string &table, const uint64_t key, const uint64_t value) {
    timer_.Start();
    Status s = db_->Update(table, key, value);
    uint64_t elapsed = timer_.End();
    if (s == kOK) {
      measurements_->Report(UPDATE, elapsed);
    } else {
      measurements_->Report(UPDATE_FAILED, elapsed);
    }
    return s;
  }
  Status Insert(const std::string &table, uint64_t key, uint64_t value) {
    timer_.Start();
    Status s = db_->Insert(table, key, value);
    uint64_t elapsed = timer_.End();
    if (s == kOK) {
      measurements_->Report(INSERT, elapsed);
    } else {
      measurements_->Report(INSERT_FAILED, elapsed);
    }
    return s;
  }
  Status Delete(const std::string &table, const uint64_t key) {
    timer_.Start();
    Status s = db_->Delete(table, key);
    uint64_t elapsed = timer_.End();
    if (s == kOK) {
      measurements_->Report(DELETE, elapsed);
    } else {
      measurements_->Report(DELETE_FAILED, elapsed);
    }
    return s;
  }
 private:
  DB *db_;
  Measurements *measurements_;
  utils::Timer<uint64_t, std::nano> timer_;
};

} // ycsbc

#endif // YCSB_C_DB_WRAPPER_H_
