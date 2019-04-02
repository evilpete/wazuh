from __future__ import absolute_import

from api.models.base_model_ import Model
from api import util

class BasicInfo(Model):

    def __init__(self, title: str=None, api_version: str=None, revision: str=None, license_name: str=None, license_url: str=None, hostname: str=None, timestamp:  str=None):  # noqa: E501
        """BasicInfo - a model defined in Swagger

        :param title: API title name.  # noqa: E501
        :type title: str

        :param api_version: API version installed in the node.  # noqa: E501
        :type api_version: str

        :param revision: Revision.  # noqa: E501
        :type revision: str

        :param license_name: API license name.  # noqa: E501
        :type license_name: str

        :param license_url: API license url.  # noqa: E501
        :type license_url: str

        :param hostname: Machine´s hostname.  # noqa: E501
        :type hostname: str

        :param timestamp: Timestamp.  # noqa: E501
        :type timestamp: str
        """
        self.swagger_types = {
            'title': str,
            'api_version': str,
            'revision': str,
            'license_name': str,
            'license_url': str,
            'hostname': str,
            'timestamp': str
        }

        self.attribute_map = {
            'title': 'title',
            'api_version': 'api_version',
            'revision': 'revision',
            'license_name': 'license_name',
            'license_url': 'license_url',
            'hostname': 'license_url',
            'timestamp': 'timestamp'
        }

        self._title = title
        self._api_version = api_version
        self._revision = revision
        self._license_name = license_name
        self._license_url = license_url
        self._hostname = hostname
        self._timestamp = timestamp

    @classmethod
    def from_dict(cls, dikt) -> 'BasicInfo':
        """Returns the dict as a model

        :param dikt: A dict.
        :type: dict
        :return: The BasicInfo of this BasicInfo.  # noqa: E501
        :rtype: BasicInfo
        """
        return util.deserialize_model(dikt, cls)

    @property
    def title(self) -> str:
        """Gets the title of this BasicInfo.


        :return: The title of this BasicInfo.
        :rtype: str
        """
        return self._title

    @title.setter
    def title(self, title: str):
        """Sets the title of this BasicInfo.


        :param title: The title of this BasicInfo.
        :type title: str
        """
        self._title = title

    @property
    def api_version(self) -> str:
        """Gets the api_version of this BasicInfo.


        :return: The api_version of this BasicInfo.
        :rtype: str
        """
        return self.api_version

    @api_version.setter
    def api_version(self, api_version: str):
        """Sets the api_version of this BasicInfo.


        :param api_version: The api_version of this BasicInfo.
        :type api_version: str
            """
        self._api_version = api_version

    @property
    def revision(self) -> str:
        """Gets the revision of this BasicInfo.


        :return: The revision of this BasicInfo.
        :rtype: str
        """
        return self.revision

    @revision.setter
    def revision(self, revision: str):
        """Sets the revision of this BasicInfo.


        :param revision: The revision of this BasicInfo.
        :type revision: str
            """
        self._revision = revision

    @property
    def license_name(self) -> str:
        """Gets the license_name of this BasicInfo.


        :return: The license_name of this BasicInfo.
        :rtype: str
        """
        return self.license_name

    @license_name.setter
    def license_name(self, license_name: str):
        """Sets the license_name of this BasicInfo.


        :param license_name: The license_name of this BasicInfo.
        :type license_name: str
            """
        self._license_name = license_name

    @property
    def license_url(self) -> str:
        """Gets the license_url of this BasicInfo.


        :return: The license_url of this BasicInfo.
        :rtype: str
        """
        return self.license_url

    @license_url.setter
    def license_url(self, license_url: str):
        """Sets the license_url of this BasicInfo.


        :param license_url: The license_url of this BasicInfo.
        :type license_url: str
            """
        self._license_url = license_url

    @property
    def hostname(self) -> str:
        """Gets the hostname of this BasicInfo.


        :return: The hostname of this BasicInfo.
        :rtype: str
        """
        return self.hostname

    @hostname.setter
    def hostname(self, hostname: str):
        """Sets the hostname of this BasicInfo.


        :param hostname: The hostname of this BasicInfo.
        :type hostname: str
            """
        self._hostname = hostname

    @property
    def timestamp(self) -> str:
        """Gets the timestamp of this BasicInfo.


        :return: The timestamp of this BasicInfo.
        :rtype: str
        """
        return self.timestamp

    @timestamp.setter
    def timestamp(self, timestamp: str):
        """Sets the timestamp of this BasicInfo.


        :param timestamp: The timestamp of this BasicInfo.
        :type timestamp: str
            """
        self._timestamp = timestamp