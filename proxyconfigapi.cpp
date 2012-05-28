/*!
 Linphone Web - Web plugin of Linphone an audio/video SIP phone
 Copyright (C) 2012  Yann Diorcet <yann.diorcet@linphone.org>

 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#include "proxyconfigapi.h"
#include "utils.h"

ProxyConfigAPI::ProxyConfigAPI(LinphoneProxyConfig *proxyConfig) :
		JSAPIAuto(APIDescription(this)), mProxyConfig(proxyConfig), mUsed(true) {
	FBLOG_DEBUG("ProxyConfigAPI::ProxyConfigAPI", "this=" << this << "\t" << "proxyConfig=" << proxyConfig);
	linphone_proxy_config_set_user_data(mProxyConfig, this);
	initProxy();
}

ProxyConfigAPI::ProxyConfigAPI() :
		JSAPIAuto(APIDescription(this)), mUsed(false) {
	FBLOG_DEBUG("ProxyConfigAPI::ProxyConfigAPI", "this=" << this);
	mProxyConfig = linphone_proxy_config_new();
	linphone_proxy_config_set_user_data(mProxyConfig, this);
	initProxy();
}

void ProxyConfigAPI::initProxy() {
	registerMethod("setServerAddr", make_method(this, &ProxyConfigAPI::setServerAddr));
	registerMethod("getServerAddr", make_method(this, &ProxyConfigAPI::getServerAddr));

	registerMethod("setIdentity", make_method(this, &ProxyConfigAPI::setIdentity));
	registerMethod("getIdentity", make_method(this, &ProxyConfigAPI::getIdentity));

	registerMethod("setRoute", make_method(this, &ProxyConfigAPI::setRoute));
	registerMethod("getRoute", make_method(this, &ProxyConfigAPI::getRoute));

	registerMethod("setExpires", make_method(this, &ProxyConfigAPI::setExpires));
	registerMethod("getExpires", make_method(this, &ProxyConfigAPI::getExpires));

	registerMethod("enableRegister", make_method(this, &ProxyConfigAPI::enableRegister));
	registerMethod("registerEnabled", make_method(this, &ProxyConfigAPI::registerEnabled));

	registerMethod("getState", make_method(this, &ProxyConfigAPI::getState));

	registerMethod("edit", make_method(this, &ProxyConfigAPI::edit));
	registerMethod("done", make_method(this, &ProxyConfigAPI::done));
}

ProxyConfigAPI::~ProxyConfigAPI() {
	FBLOG_DEBUG("ProxyConfigAPI::~ProxyConfigAPI", "this=" << this);
	linphone_proxy_config_set_user_data(mProxyConfig, NULL);
	if(!mUsed) {
		linphone_proxy_config_destroy(mProxyConfig);
	}
}

int ProxyConfigAPI::setServerAddr(const std::string &server_addr) {
	FBLOG_DEBUG("ProxyConfigAPI::setServerAddr()", "this=" << this << "\t" << "server_addr=" << server_addr);
	return linphone_proxy_config_set_server_addr(mProxyConfig, server_addr.c_str());
}
std::string ProxyConfigAPI::getServerAddr() const {
	FBLOG_DEBUG("ProxyConfigAPI::getServerAddr()", "this=" << this);
	const char *txt = linphone_proxy_config_get_addr(mProxyConfig);
	return txt != NULL ? txt : "";
}

int ProxyConfigAPI::setIdentity(const std::string &identity) {
	FBLOG_DEBUG("ProxyConfigAPI::setIdentity()", "this=" << this << "\t" << "identity=" << identity);
	return linphone_proxy_config_set_identity(mProxyConfig, identity.c_str());
}
std::string ProxyConfigAPI::getIdentity() const {
	FBLOG_DEBUG("ProxyConfigAPI::getIdentity()", "this=" << this);
	const char *txt = linphone_proxy_config_get_identity(mProxyConfig);
	return txt != NULL ? txt : "";
}

int ProxyConfigAPI::setRoute(const std::string &route) {
	FBLOG_DEBUG("ProxyConfigAPI::setRoute()", "this=" << this << "\t" << "route=" << route);
	return linphone_proxy_config_set_route(mProxyConfig, route.c_str());
}
std::string ProxyConfigAPI::getRoute() const {
	FBLOG_DEBUG("ProxyConfigAPI::getRoute()", "this=" << this);
	const char *txt = linphone_proxy_config_get_route(mProxyConfig);
	return txt != NULL ? txt : "";
}

void ProxyConfigAPI::setExpires(int expires) {
	FBLOG_DEBUG("ProxyConfigAPI::expires()", "this=" << this << "\t" << "expires=" << expires);
	return linphone_proxy_config_expires(mProxyConfig, expires);
}
int ProxyConfigAPI::getExpires() const {
	FBLOG_DEBUG("ProxyConfigAPI::getExpires()", "this=" << this);
	return linphone_proxy_config_get_expires(mProxyConfig);
}

void ProxyConfigAPI::enableRegister(bool val) {
	FBLOG_DEBUG("ProxyConfigAPI::enableRegister()", "this=" << this << "\t" << "val=" << val);
	return linphone_proxy_config_enable_register(mProxyConfig, val ? TRUE : FALSE);
}
bool ProxyConfigAPI::registerEnabled() const {
	FBLOG_DEBUG("ProxyConfigAPI::registerEnabled()", "this=" << this);
	return linphone_proxy_config_register_enabled(mProxyConfig) == TRUE ? true : false;
}

int ProxyConfigAPI::getState() {
	FBLOG_DEBUG("ProxyConfigAPI::getState()", "this=" << this);
	return linphone_proxy_config_get_state(mProxyConfig);
}

void ProxyConfigAPI::edit() {
	FBLOG_DEBUG("ProxyConfigAPI::edit()", "this=" << this);
	linphone_proxy_config_edit(mProxyConfig);
}

int ProxyConfigAPI::done() {
	FBLOG_DEBUG("ProxyConfigAPI::done()", "this=" << this);
	return linphone_proxy_config_done(mProxyConfig);
}

ProxyConfigAPIPtr ProxyConfigAPI::get(LinphoneProxyConfig *proxyConfig) {
	if(proxyConfig == NULL)
		return ProxyConfigAPIPtr();

	void *ptr = linphone_proxy_config_get_user_data(proxyConfig);
	ProxyConfigAPIPtr shared_ptr;
	if (ptr == NULL) {
		shared_ptr = ProxyConfigAPIPtr(new ProxyConfigAPI(proxyConfig));
	} else {
		shared_ptr = boost::static_pointer_cast<ProxyConfigAPI>(reinterpret_cast<ProxyConfigAPI *>(ptr)->shared_from_this());
	}
	return shared_ptr;
}
